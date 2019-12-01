In this _Operator_ pattern_ we expand on the [_Controller_](../21-Controller) pattern and introduce a Custom Resource Definition for our ConfiMap watch controller. So if you haven't run the Controller scenario we recommend to do so now.

So, instead of annotating a ConfigMap with a Pod selector we use a dedicated custom resource ``  which contains a reference to the ConfigMap to watch and a selector for the Pods to restart in case the ConfigMap has changed.

The functionality remains the same, but you have a nice decoupling of ConfigMap and the applications which are using it and you can have multiple different Pods be restarted by creating multiple
That way, you can support hot-pickup of your ConfigMap changes for an application that doesn't support hot reload of configuration or use the ConfigMap's values as environment variables.

Here you will learn:

* how to write a simple shell-based Controller which triggers on annotations
* how to easily talk to the Kubernetes API server from within a container with the help of a Sidecar
