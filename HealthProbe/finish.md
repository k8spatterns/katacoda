In this scenario you learned about two ways how you can implement the different _Health Probes_ which have meaning to Kubernetes:

* A _readiness probes_ for indicating when your application is ready to serve or whether is should be excluded from the route.
* A _liveness probe_ which causes a container to be restart if it fails.

Much more information for this and other patterns can be found in the [Kubernetes Patterns](https://k8spatterns.io) book. Also don't forget to check out the examples at the books' [example GitHub repository](https://github.com/k8spatterns/examples).
