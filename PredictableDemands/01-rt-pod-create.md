
While you are reading this we are starting a simple single node Kubernetes cluster for you. Please be patient and wait until the `launch.sh` script has finished.

Now ensure that the node is up

`kubectl get nodes -w`{{execute}}

Please wait until the `STATUS` has switched to "Ready" and then press <kbd>CTRL-C</kbd>.

Now let's create a simple Pod which references a non-existing ConfigMap `random-generator-config`.
The Pod itself is a simple REST service which just returns a freshly generated random number each time it is called.

In `pod.yml` you find the definition of a bare Pod which references a ConfigMap for being used as environment variables.

Check the content of this declaration with

`bat pod.yml`{{execute}}

Let's create now that Pod with

`kubectl create -f pod.yml`{{execute}}

and watch how it starts up:

`kubectl get pods -w`{{execute}}

(you can stop this with <kbd>CTRL-C</kbd> or just start the next command).

As you can see, that Pod won't start because a hard **runtime requirement** is missing.
We need to add the referenced ConfigMap first.

Let's do this with

`kubectl create cm random-generator-config --from-literal pattern="Predictable Demands"`{{execute interrupt}}

and check the pods again

`kubectl get pods -w`{{execute}}

Perfect! The Pod is now up and running.

Since this shell is running within the Kubernetes cluster, we can reach the Pod directly.
So extract the Pod's internal IP first with

`pod_id=$(kubectl get pod random-generator -o jsonpath="{.status.podIP}")`{{execute interrupt}}

and access the rest service with

`curl -s http://$pod_id:8080/info | jq .`{{execute}}

Do you spot the environment we just set ?

After we have now seen how we can resolve the hard requirement on a ConfigMap can be, let's check out how _resource profiles_ are working.
