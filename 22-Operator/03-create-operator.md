Let's now put our Operator as a container image, the same way as we did for our controller examples.

In our deployment that we are going to create we will use a standard base image which has the tools that we need within the script, i.e. `curl` and `jq`. `k8spatterns/curl-jq` is such a simple image.

We will put the script itself into a ConfigMap and mount this ConfigMap as a volume into our deployment so that we can quickly start if from there (and also update it if necessary).

Let's create the ConfigMap first:

`kubectl create configmap operator-script --from-file=./operator.sh`{{execute}}

This command creates a ConfigMap with a single entry with key `operator.sh` and the operator script as content.

We use again `k8spatterns/kubeapi-proxy` as a Sidecar our operator Pod as a sidecar to let the operator script access the API server at localhost. This _Sidecar_, or better _Ambassador_ (both are patterns described in the book) proxies the real API server form localhost and port 8001, much the same way as we did for locally running our operator.

Check out the full deployment, along with the proper permission setup to be able to watch ConfigMaps and delete pods:

`bat operator.yml`{{execute interrupt}}

so that we can now deploy it with

`kubectl create -f operator.yml`{{execute interrupt}}

Check and wait until the operator Pod is running.

`watch kubectl get pods`{{execute}}

To see our operator in action, let's create a simple web application in the next step.
