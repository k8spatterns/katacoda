Our Pod needs the ConfigMap `random-generator-config` to be able to start up.

Let's create it with

`kubectl create cm random-generator-config --from-literal pattern="Predictable Demands"`{{execute interrupt}}

and check the pods again

`kubectl get pods -w`{{execute}}

Perfect! The Pod is now up and running.

But does the Pod also picked up the data of our ConfigMap ? Let's check that
in the next step.
