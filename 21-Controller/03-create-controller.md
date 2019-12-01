Let's now put our Controller as a container image.

In our deployment that we are going to create we will use a standard base image which has the tools that we need within the script, i.e. `curl` and `jq`. `k8spatterns/curl-jq` is such a simple image.

We will put the script itself into a ConfigMap and mount this ConfigMap as a volume into our deployment so that we can quickly start if from there (and also update it if necessary).

Let's create the ConfigMap first:

`kubectl create configmap controller-script --from-file=./controller.sh`{{execute}}

This command creates a ConfigMap with a single entry with key `controller.sh` and the controller script as content.

Before we create the final controller Deployment, we have to talk about how this script can access the API server for watching for resource changes. We use an _Ambassador_ which proxies a port on localhost to the API server's rest endpoint, including the complete security setup.
The sidecar image for the _Ambassador_ has been already created and is available from Docker Hub as `k8spatterns/kubeapi-proxy`.The [Dockerfile](https://github.com/k8spatterns/examples/blob/master/advanced/images/kubeapi-proxy.dockerfile) is very simple, the important part is how `kubectl` is started within the image:

```
ENTRYPOINT [ \
  "/bin/ash", "-c", \
  "/kubectl proxy \
     --server https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT \
     --certificate-authority=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
     --token=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token) \
     --accept-paths='^.*' \
  "]
```

This example shows nicely how the Kubernetes API service is exposed as `$KUBERNETES_SERVICE_HOST` and `$KUBERNETES_SERVICE_PORT` environment variables to every Pod and how the credentials and certificates are picked up from the service account data that is mirrored into the Pod. Kudos to [Marko Lukša](https://github.com/luksa) who uses this proxy trick first in his excellent book [Kubernetes in Action](https://www.manning.com/books/kubernetes-in-action).

We use this image within our controller Pod as a sidecar to let the controller script access the API server at localhost. This _Sidecar_, or better _Ambassador_ (both are patterns described in the book) proxies the real API server form localhost and port 8001, much the same way as we did for locally running our controller.

Check out the full deployment with

`bat controller.yml`{{execute interrupt}}

so that we can now deploy it with

`kubectl create -f controller.yml`{{execute interrupt}}

Check and wait until the controller Pod is running.

`watch kubectl get pods`{{execute}}

To see our controller in action, let's create a simple web application in the next step.
