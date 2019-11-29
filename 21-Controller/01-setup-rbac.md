Before we start we need to setup permissions so that our Controller is able to connect to the API server and is allowed to read ConfigMap relevant events and to kill Pods

For simplity reasons, we are re-using the `edit` role. For more realistic setups you should restrict the permissions for your controller to only those permissions which are required to perform the action.

First check the service account `config-watcher-controller` and the role we are using:

`bat rbac.yml`{{execute T1}}

Let's apply them to the cluster now so that we can use it later for our Controller deployment:

`kubectl apply -f rbac.yml`{{execute T2}}

Now it's time to dive into the logic of our simple Controller in the next step.
