Now let's see how our ConfigMap Watch-Controller works.

It is implemented in an shell script `controller.sh` which we will later put into a container image. The shell script consists of several function.

Let's have a look to the main loop:

`bat -r 13:39 controller.sh`{{execute}}

This is the main loop which endlessly queries the API server in a watch mode:

```bash
# Event loop listening for changes in config maps
curl -N -s $base/api/v1/${ns}/configmaps?watch=true | while read -r event
do
  ...
done
```

The variables used here are defined in the top of the script as

```bash
# Namespace to watch (or 'default' if not given)
namespace=${WATCH_NAMESPACE:-default}

# API URL setup. Requires an ambassador API proxy running side-by-side on localhost
base=http://localhost:8001
ns=namespaces/$namespace
```

So, by default this controller watches on the `default` namespace and reaches out to the API server via `http://localhost:8001`. How does this work ?

If you want to run the controller locally, just start a proxy in the background like with

`kubectl proxy --port=8001 &`{{execute}}

and then run the controller script also in the background

`bash controller.sh &`{{execute}}

Just for testing add and remove a configmap temporarily

`kubectl create -f configmap.yml`{{execute}}
`kubectl delete -f configmap.yml`{{execute}}

Can you see how the events are processed ?

To clean up, lets kill the background processes

`kill %1 %2`{{execute}}

In the next section we will see how we can use an _Ambassador_ for implementing a similar proxy within a Pod.

------------

Back to our script. The query option `watch=true` in the API server request causes the API server to not close the connection but send events to the client as they come in.

Within the loop we are using `jq` and jsonpath to extract certain fields from the events as they come in. Such an event looks like

```json
{
  "type": "ADDED",
  "object": {
    "kind": "ConfigMap",
    "apiVersion": "v1",
    "metadata":
      "name": "webapp-config",
      "annotations": {
       "k8spatterns.io/podDeleteSelector": "app=webapp"
     },
     ...
    },
    "data": {
      ...
    }
  }
}
```

i.e. it contains the type of the event (`ADDED`) and the resource object itself.

In

```
# Event type & name
local type=$(echo "$event" | jq -r .type)
local config_map=$(echo "$event" | jq -r .object.metadata.name)

# Fetch annotations of ConfigMap and extract our trigger annotation if any
local annotations=$(echo "$event" | jq -r '.object.metadata.annotations')
```

various fields are extracted from the received event via `jq`.

If the ConfigMap carries an annotation `k8spatterns.io/podDeleteSelector`, then its value is extracted and UIR decoded. This happens with the straight-forward jq expression:

```
local pod_selector=$(echo $annotations | \
    jq -r 'to_entries | \
           .[] | \
           select(.key == "k8spatterns.io/podDeleteSelector") | \
           .value | \
           @uri' )
```

With this selector then eventually the matching Pods are first queried and then
deleted with the function in

`bat -r 41:62 controller.sh`{{execute}}

------------

Now that we understand how the controller can restart Pods based on ConfigMap `MODIFIED` events, lets now see in the next step how we can deploy it.
