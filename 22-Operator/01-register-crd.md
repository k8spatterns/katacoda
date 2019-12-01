In order to expand on our [Controller](21-controller), let's introduce a dedicated CRD for describing the relationship between the ConfigMap to watch and the Pods to restart when that ConfigMap changes.

For this we will introduce a custom resource that looks like

```
kind: ConfigWatcher
apiVersion: k8spatterns.io/v1
metadata:
  name: webapp-config-watcher
spec:
  # The config map's name which should be watched
  configMap: webapp-config
  # A label selector for the pods to delete in case
  podSelector:
    app: webapp
```

The first step is to register a _CustomResourceDefinition_ (CRD) which can be found in

`bat crd.yml`{{execute}}

This CRD contains the kind, group and version and some other extra information like an OpenAPI schema for validation and also additional columns to print with `kubectl get`.

Let's apply it to our cluster:

`kubectl apply -f crd.yml`{{execute}}

In addition we create a role `config-watcher-crd` which grants access to this `ConfigWatcher` custom resources, so that later our operator can monitor changes on these resources:

`kubectl apply -f crd-role.yml`{{execute}}

In the next step lets check out the logic of our operator which uses instances of the `ConfigWatcher` CRD as input.
