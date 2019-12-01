In this scenario, we give a brief example how Operator works by introducing CRDs and watching the current status of the cluster periodically. The benefit of using a dedicated Operator instead of a ConfigMap watching controller is, that the Operator is less intrusive and nicely decouples the componentns being managed.

We have learned ...

* ... how to define a custom resource with a validation schema and other meta information.
* ... that you can write also operators in shell script to watch multiple resources.
* ... how to access the Kubernetes API server from within a Pod, including the security setup
* ... how to run an HTTP server with `netcat`

More background information about the _Operator_ pattern can be found in our  [Kubernetes Patterns](https://k8spatterns.io) book.

But be aware that for a *real* operator, you need more than this simple example script:

* Improve the resilience of the Operator by reconnecting to the event stream when the connections breaks and refetching the full state periodically. If you are writing your applications in Golang or Java, the supporting libraries support so called `Informers` which can do this transparently for you.
* We could update `status:` field on the custom resource to indicate whether its e.g. active or not. how many pods are matching, etc.
* Also, we could introduce a _validating admission webhook_ which could verify that the ConfigMap that is referenced in the `ConfigWatcher` indeed exists when it is created. This kind of validation is goes beyond simple OpenAPI validation and is recommended for advanced use cases.
