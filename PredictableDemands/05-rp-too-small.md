We are now reducing the `requests` and `limits` to 20 MB which is for sure too small for the service to run.

We can update our current deployment with a simple `kubectl patch`.

The JSON patch can be viewed with

`bat resources-patch.json`

It effectively replaces the previos resources and limits with 20 MB.

`kubectl patch deploy random-generator --type=json -p $(cat resources-patch.json)`{{execute}}

As soon as you do this watch again the Pods

`watch kubectl get pods`

First they are restarted because you have changed the Deployment, but you see how they fail to start again because the memory limits are just too tight.

Now take your time an examine the situation a bit more.

* Examine the pods with `kubectl decscribe pod random-generator-`{{copy}} for one of the failing Pods. Can you see there the reason why the Pod has not started ?
* Also interesting: `kubectl describe deployment random-generator`{{copy}}
* How can you fix the requirements again ? Try `kubectl edit deployment random-generator`{{copy}} and set the requests/limits to a sane value again.

That ends our quick example of the _Predictable Demands_ pattern.
