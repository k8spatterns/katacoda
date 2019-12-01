We use a straightforward HTTP server deployment to test our ConfigMap watch controller.

Have a look at its Deployment:

`bat webapp.yml`{{execute interrupt}}

The web service is probably the simplest HTTP Server possible. [k8spatterns/mini-http-server](https://github.com/k8spatterns/examples/blob/master/advanced/images/mini-http-server.dockerfile) uses just netcat to expose the content of the environment variable `$MESSAGE` as HTTP response:

```bash
while true ; do
  echo -e \"HTTP/1.1 200 OK\n\n $MESSAGE\n\" | nc -l -p 8080 -q 1;
done
```

The `$MESSAGE` variable comes from a ConfigMap that we install along with the web application itself:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: webapp-config
data:
  message: "Welcome to the Operator Pattern !"
```

Note, that this ConfigMap does not have any annotations and is totally disconnected to any Pods that is using this ConfigMap.

Let's deploy that application and the ConfigMap:

`kubectl apply -f webapp.yml`{{execute interrupt}}

Also, a service of type `nodePort` is deployed, so that we can quickly test it locally.

`curl -s http://[[HOST_IP]]:31669`{{execute}}

Finally, we are now creating a custom resource `ConfigWatcher` to connect the dots.
