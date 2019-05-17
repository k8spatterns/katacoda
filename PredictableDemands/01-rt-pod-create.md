
As very first lets start a simple one node Kubernetes cluster with

`launch.sh`{{execute}}

Let's check whether its running

`kubectl get nodes`{{execute}}

Please ensure to wait until the status is "Ready".

Now let's create a simple Pod which references a non-existing ConfigMap `random-generator-config`.
The Pod itself is a simple REST service which just returns a freshly generated random number each time it is called.

Copy this Pod declaration which you should copy over. It is then saved as "pod.yml"

<pre class="file" data-filename="pod.yml" data-target="replace">apiVersion: v1
kind: Pod
metadata:
  name: random-generator
spec:
  containers:
  - image: k8spatterns/random-generator:1.0
    name: random-generator</pre>

This reset service uses an environment variable `PATTERN`. Let's add this
to our Pod with

<pre class="file" data-filename="pod.yml" data-target="append">apiVersion: v1
    env:
    - name: PATTERN
      valueFrom:
        configMapKeyRef:
          name: random-generator-config
          key: pattern
</pre>

Let's create that Pod with

`kubectl create -f pod.yml`{{execute}}

and watch how it starts up:

`kubectl get pods -w`{{execute}}

(you can stop this with <kbd>CTRL</kbd>-<kbd>C</kbd> or just start the next command).

As you can see, that Pod won't start because a hard **runtime requirement** is missing.
We need to add the referenced ConfigMap first.

Let's do this with

`kubectl create cm random-generator-config --from-literal pattern="Predictable Demands"`{{execute interrupt}}

and check the pods again

`kubectl get pods -w`{{execute}}

Perfect! The Pod is now up and running.

Since this shell is running within the Kubernetes cluster, we can reach the Pod directly.
So extract the Pod's internal IP first with

`pod_id=$(kubectl get pod random-generator -o jsonpath="{.status.hostIP}")`{{execute interrupt}}

and access the rest service with

`curl https://$pod_id:8080/info | jq .`

Do you spot the environment we just set ?

After we have now seen how we can resolve the hard requirement on a ConfigMap can be, let's check out how _resource profiles_ are working.
