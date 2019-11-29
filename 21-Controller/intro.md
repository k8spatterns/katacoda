Welcome to the _Controller Pattern_. In this scenario, we will learn how we can write a simple _Controller_ just with a plain shell script.

This controller monitors all ConfigMaps which carry an annotation `k8spatterns.io/podDeleteSelector`. If such a ConfigMap is modified, then all Pods which match the label-selector taken from the annotation's value will be deleted.

That way, you can support hot-pickup of your ConfigMap changes for an application that doesn't support hot reload of configuration or use the ConfigMap's values as environment variables.

Here you will learn:

* how to write a simple shell-based Controller which triggers on annotations
* how to easily talk to the Kubernetes API server from within a container with the help of a Sidecar
