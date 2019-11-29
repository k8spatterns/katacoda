In this scenario we introduced Controllers and how they can add functionality by sitting in the background and checking your resources.

We have learned ...

* ... that you can write controllers in shell script (and hence in every real language :). Please be aware though that this is just a demo project and e.g. will fail as soon as your intial watch curl request breaks. Use a real language with some library support like from the operator-sdk for creating production grade controllers
* ... how to access the Kubernetes API server from within a Pod, including the security setup
* ... how to run a HTTP server with `netcat`

More background information about the _Controller_ pattern can be found in our  [Kubernetes Patterns](https://k8spatterns.io) book. Also don't forget to check out the examples at the books' [example GitHub repository](https://github.com/k8spatterns/examples) and also the [Dockerfiles](https://github.com/k8spatterns/examples/blob/master/advanced/images) for the base images as they might be useful on their own.
