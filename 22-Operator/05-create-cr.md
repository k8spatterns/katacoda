To connect the ConfigMap and the application's Pods, we are creating the following custom resource:

```
kind: ConfigWatcher
apiVersion: k8spatterns.io/v1
metadata:
  name: webapp-config-watcher
spec:
  # The config map's name which should be watched
  configMap: webapp-config
  # A label selector for the pods to delete if the
  # given config map changes
  podSelector:
    app: webapp
```

Let's apply that CR

`kubectl apply -f config-watcher.yml`{{execute}}

Now that everything is set up let's adapt the web applications' configuration to provide a new response message

`kubectl patch configmap webapp-config -p '{"data":{"message":"Bye, Bye!"}}'`{{execute}}

Does our web application pick up this new configuration? Let's check (you might have to wait a bit for the Pod to come up)

`curl -s http://[[HOST_IP]]:31670`{{execute}}

Heureka! You can verify that it was indeed our controller who performed the restart of the Pod by checking the operator logs:

`pod=$(kubectl get pod -o name | grep operator | sed -e "s/^pods\///")`{{execute}}
`kubectl log $pod -c config-watcher`{{execute}}

Finally, let's check how our resource is shown via `kubectl`:

`kubectl get cw`{{execute}}

That's the end of our short introduction into the world of operators.
