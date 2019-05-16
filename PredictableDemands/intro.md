This scenario demonstrates the _Predictable Demands_ pattern from (https://k8spatterns.io)[Kubernetes Patterns].

This pattern is about how you should declare application requirements, whether they are hard runtime dependencies or resource requirements.
Declaring your requirements is essential for Kubernetes to find the right place for your application within the cluster.

After this scenario you know

* how to detect that a hard runtime requirement like a ConfigMap is missing
* how define resources limits for CPU and Memory
* what happens when these limits are selected too low
