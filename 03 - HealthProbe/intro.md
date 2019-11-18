In this scenario we see how the _Health Probe_ pattern from [Kubernetes Patterns](https://k8spatterns.io) is implemented by Kubernetes.

In this example we create a Deployment which exposes a _liveness_ and a _readiness_ probe for allowing Kubernetes to detect the health of your application and whether it's ready to serve its business functionality or whether it might need a restart for restoring from a failure.

After this scenario you know

* how a failing _liveness probe_ will tigger Kubernetes to restart your application.
* how _readiness probe_ will enable and disable the access to your service.
