We use a straightforward HTTP server deployment to test our ConfigMap watch controller.

Have a look at its Deployment:

`bat webapp.yml`{{execute interrupt}}

The web service is probably the simplest HTTP Server possible. [k8spatterns/mini-http-server](https://github.com/k8spatterns/examples/blob/master/advanced/images/mini-http-server.dockerfile) uses just netcat to expose the content of the environment variable `$MESSAGE` as HTTP response:

```bash
while true ; do
  echo -e \"HTTP/1.1 200 OK\n\n $MESSAGE\n\" | nc -l -p 8080 -q 1;
done
```

Let's deploy that application with

`kubectl apply -f webapp.yml`{{execute interrupt}}

If you check with

`kubectl get pods`{{execute}}

you will see that it doesn't startup.

Ah, we forgot to set up the ConfigMap which is referenced to in our Deployment. Let's create one.

`bat configmap.yml`{{execute}}

Please note the annotation with a selector to the Pods that we want to restart. This selector is applied when the ConfigMap changes and it will find all Pods that belong to the `webapp` Deployment.

When we create the ConfigMap with

`kubectl apply -f configmap.yml`{{execute}}

you will see our web app Pod starting:

`kubectl get pods`{{execute}}

Also, a service of type `nodePort` is deployed, so that we can quickly test it locally.

`curl -s http://[[HOST_IP]]:31669`{{execute}}

In the final step, we will adapt this friendly message just by updating the ConfigMap `webapp-config` and let our controller do the dirty work.
