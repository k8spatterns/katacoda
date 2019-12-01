Now that everything is set up let's adapt the web applications' configuration to provide a new response message

`kubectl patch configmap webapp-config -p '{"data":{"message":"Good Bye!"}}'`{{execute}}

Does our web application pick up this new configuration? Let's check (you might have to wait a bit for the Pod to come up)

`curl -s http://[[HOST_IP]]:31669`{{execute}}

Heureka! You can verify that it was indeed our controller who performed the restart of the Pod by checking the controller logs:

`pod=$(kubectl get pod -o name | grep webapp | sed -e "s/^pods\///)`{{execute}}
`kubectl log $pod -c config-watcher`{{execute}}

This last check concludes our quick tour through the world of controllers.
