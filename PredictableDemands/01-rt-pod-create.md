
As very first lets start a simple one node Kubernetes cluster with

`launch.sh`{{execute}}

Let's check whether its running

`kubectl get nodes`{{execute}}

Please ensure to wait until the status is "Ready".

Now let's create a simple Pod which references a non-existing ConfigMap `random-generator-config`.
The Pod itself is a simple REST service which just returns a freshly generated random number each time it is called.

Here's the Pod declaration which you should copy over. It is then saved as "pod.yml"

<pre class="file" data-filename="pod.yml" data-target="replace">apiVersion: v1
kind: Pod
metadata:
  name: random-generator
spec:
  containers:
  - image: k8spatterns/random-generator:1.0
    name: random-generator
    - name: PATTERN
      valueFrom:
        configMapKeyRef:
          name: random-generator-config
          key: pattern
</pre>

Let's create the Pod with

`kubectl create -f pod.yml`{{execute}}


Render port 80: https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/

Display page allowing user to select port:
https://[[HOST_SUBDOMAIN]]-[[KATACODA_HOST]].environments.katacoda.com/

`curl https://[[HOST_SUBDOMAIN]]-[[KATACODA_HOST]].environments.katacoda.com/`{{copy}}
