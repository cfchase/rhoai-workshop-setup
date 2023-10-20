SHELL := /bin/bash

.EXPORT_ALL_VARIABLES:

PROJECT_NAME = workshop


.PHONY: all
all: dsproject default

.PHONY: dsproject
dsproject:
	oc process -f 'data-science-project/project.yml' -p PROJECT_NAME=$(PROJECT_NAME) | oc apply -f -

.PHONY: default
default:
	oc apply -n $(PROJECT_NAME) -k kustomize/overlays/default

.PHONY: s3
s3:
	oc apply -n $(PROJECT_NAME) -k kustomize/overlays/s3

.PHONY: inference
inference:
	oc apply -n $(PROJECT_NAME) -k kustomize/overlays/inference

.PHONY: test-route
test-route:
	oc create route edge ai-service --service=ai-service -n $(PROJECT_NAME)
