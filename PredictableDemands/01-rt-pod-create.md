
<pre class="file" data-filename="pod.yaml" data-target="replace">apiVersion: v1
kind: Pod
metadata:
  name: random-generator
spec:
  containers:
  - image: k8spatterns/random-generator:1.0
    name: random-generator
</pre>



<pre class="file" data-filename="pod.yaml" data-target="append">    env:
    - name: PATTERN
      valueFrom:
        configMapKeyRef:
          name: random-generator-config
          key: pattern
</pre>


<pre class="file" data-filename="pod.yaml" data-target="regexPATTERN">BLA</pre>
