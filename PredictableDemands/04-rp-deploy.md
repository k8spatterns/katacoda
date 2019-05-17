
Now lets create a Deployment for a Pod with resource limits set.

Check the Deployment that we have prepared with

`bat deployment.yml`{{execute}}

As you can see in the `resources:` section you find `requests:` and `limist:` specifications for starting up the container with initial 100 MB (request) up to 200 MB (limits) memory allocated. We are also using three replicas of our service.

This works nicely for our Spring Boost example REST app, so we can create that with

`kubectl create -f deployment.yml`{{execute}}

We can again verify that the Pods are running with

`watch kubectl get pods`{{execute}}

Now let's access the random-generator via a Service of type `nodePort`, which opens up a port 31666 on every node. In our case this is of course only the master node.

`kubectl create -f service.yml`{{execute interrupt}}

The service can be accessed in Katacoda with

`curl http://[[HOST_IP]]:31666/health | jq .`{{execute}}

or you can also reach it externally via http://[[HOST_SUBDOMAIN]]-31666-[[KATACODA_HOST]].environments.katacoda.com/

The `/health` endpoint exposes also the memory used by the JVM from the POV of the JVM. Can you spot how much memory the random-generator is using ?

Everythings looks good now. But what happens if we change the restrictions so that the JVM will blow that away ?

Let's check that in the next step.
