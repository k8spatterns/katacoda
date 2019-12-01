In this _Operator_ pattern_ we expand on the [_Controller_](../21-controller) pattern and introduce a Custom Resource Definition for our ConfiMap watch controller. So if you haven't run the Controller scenario we recommend to do so now.

So, instead of annotating a ConfigMap with a Pod selector we use a dedicated custom resource `ConfigWatcher`  which contains a reference to the ConfigMap to watch and a selector for the Pods to restart in case the ConfigMap has changed.

The functionality remains the same, but you have a nice decoupling of ConfigMap and the applications which are using it and you can have multiple different Pods be restarted by creating multiple
That way, you can support hot-pickup of your ConfigMap changes for an application that doesn't support hot reload of configuration or use the ConfigMap's values as environment variables.

In this scenario you will learn:

* how to create a CustomResourceDefinition
* how to implement an operator in shell-script that watches multiple resources
