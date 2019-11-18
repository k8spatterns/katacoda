
Since this shell is running within the Kubernetes cluster, we can reach the Pod directly.
So extract the Pod's internal IP first with

`pod_ip=$(kubectl get pod random-generator -o jsonpath="{.status.podIP}") && echo $pod_ip`{{execute interrupt}}

and access the rest service with

`curl -s http://$pod_ip:8080/info | jq .`{{execute}}

Do you spot the environment we just set ?

After we have now seen how we can resolve the hard requirement on a ConfigMap can be, let's check out how _resource profiles_ are working.

But before we move on, let's delete the Pod to start clean

`kubectl delete pod random-generator`{{execute}}
