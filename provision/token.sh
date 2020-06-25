#!/bin/bash

export TOKEN=$(kubectl get secret -n kubernetes-dashboard $(kubectl get serviceaccount kubernetes-dashboard -n kubernetes-dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode)

echo $TOKEN >>  token.txt
