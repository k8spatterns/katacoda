Before we start we need to set up permissions so that our Controller can connect to the API server and is allowed to read ConfigMap relevant events and to kill Pods

For the sake of simplicity, we are re-using the standard `edit` role. For more realistic setups you should restrict the permissions for your controller to only those permissions which are required to act.

After the Kubernetes cluster is initialized, let's check the service account `config-watch-controller` and the role we are using:

`bat rbac.yml`{{execute}}

Let's apply them to the cluster now so that we can use it later for our Controller deployment:

`kubectl apply -f rbac.yml`{{execute}}

Now it's time to dive into the logic of our simple Controller in the next step.
