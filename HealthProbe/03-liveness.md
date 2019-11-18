In order to make our liveness-probe fail, our application offers an endpoint `toggle-live` to artifically make our application to fail the liveness probe.

However, we better access this endpoint not via the Service, which might not be active e.g. because of a failing _readiness probe_.

So let's create a port forward directly to the Pod.

Our single pod is assumed to be stored in the `$pod` shell variable, which you can simply set with

`pod=$(kubectl get pods -l app=random-generator -o name | sed -e 's|pod/||')`{{execute}}

So that we now can start the port forward in the background with

`kubectl port-forward $pod 8080:8080 &`{{execute}}

so that we can reach our Pod on `localhost:8080`.

To toggle the liveness check, just switch it with

`curl -s http://localhost:8080/toggle-live`{{execute}}

Now take your popcorn and watch what happens to our Pod

`kubectl get pods -w`{{execute}}

This might take a bit. As you will see, after a single restart, the readiness and liveness probe are ok again, as we started a fresh.
So, in our example we "fixed" our issue with the out-of-order service just by a restart as the trigger file is recreated after each restart.

This concludes our quick walkthrough, but you don't have to stop here:

* What happens when you scale up to multiple replicas ?
* Which are the parameters to tune your health checks ? The [Kubernetes API specification](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.16/#probe-v1-core) contains all parameters which you can use here:
  - `initialDelaySeconds` for the ramp-up time before the first check
  - `timeoutSeconds` how long to wait for the health check to respond
  - `periodSeconds` for the check intervals
  - `failureThreshold` how often for a check to fail before taking an action.

In order to play with these parameters use

`kubectl edit deploy/random-generator`{{execute interrupt}}

and adapt the `livenessProbe` and `readinessProbe` sections.
