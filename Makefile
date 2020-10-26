DOCKER_REGISTRY := $(or $(DOCKER_REGISTRY),$(REGISTRY_HOST))
VALUES_REGISTRY_TMPL := $(or $(VALUES_REGISTRY_TMPL), values-registry.tmpl)

.EXPORT_ALL_VARIABLES:

ALPINE_TAG := 3.8
SELENIUM_TAG := v1
KEYCLOAK_TAG := 11.0.2.Final
POSTGRES_TAG := 11.7
AAE_TAG := 7.1.0-M10
MINIDEB_EXTRAS_TAG := stretch

IMAGES := alpine@$(ALPINE_TAG) \
jboss/keycloak@$(KEYCLOAK_TAG) \
unguiculus/docker-python3-phantomjs-selenium@$(SELENIUM_TAG) \
postgres@$(POSTGRES_TAG) \
bitnami/minideb-extras@${MINIDEB_EXTRAS_TAG} \
docker@${DIND_TAG} \
quay.io/alfresco/alfresco-admin-app@${AAA_TAG} \
quay.io/alfresco/alfresco-deployment-service@${AAE_TAG} \
quay.io/alfresco/alfresco-modeling-app@${AMA_TAG} \
quay.io/alfresco/alfresco-modeling-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-runtime-bundle-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-query-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-storage-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-notifications-graphql-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-workspace-app@${AAE_TAG} \
quay.io/alfresco/alfresco-process-camel-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-comprehend-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-content-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-docgen-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-docusign-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-email-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-lambda-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-rekognition-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-rest-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-salesforce-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-slack-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-textract-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-twilio-connector-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-elasticsearch-bridge-service@${AAE_TAG} \
quay.io/alfresco/alfresco-process-kafka-bridge-service@${AAE_TAG}

.PHONY: $(IMAGES)

all: images values-registry.yaml

test:
	@if test -z "$(DOCKER_REGISTRY)"; then echo "Error: missing DOCKER_REGISTRY argument or env variable."; exit 1; fi

login: test
	docker login quay.io
	docker login $(DOCKER_REGISTRY)

pull: $(foreach image,$(IMAGES),$(image)\pull)

tag: test $(foreach image,$(IMAGES),$(image)\tag)

push: test $(foreach image,$(IMAGES),$(image)\push)

list: $(foreach image,$(IMAGES),$(image)\print)

images: test pull tag push

values-registry.yaml: test
	@envsubst < $(VALUES_REGISTRY_TMPL) > values-registry.yaml
	@echo Values generated in values-registry.yaml

clean:
	rm values-registry.yaml || true

$(IMAGES):
	make $@\\pull
	make $@\\tag
	make $@\\push

$(foreach image,$(IMAGES),$(image)\pull): ## Pull container image
	$(eval IMAGE := $(subst \, ,$@))
	docker pull $(word 1, $(subst @,:,$(IMAGE)))

$(foreach image,$(IMAGES),$(image)\tag): ## Tag container image
	$(eval IMAGE := $(subst \, ,$@))
	docker tag $(word 1, $(subst @,:,$(IMAGE))) $(DOCKER_REGISTRY)/$(word 1, $(subst @,:,$(IMAGE)))

$(foreach image,$(IMAGES),$(image)\push): ## Push container image
	$(eval IMAGE := $(subst \, ,$@))
	docker push $(DOCKER_REGISTRY)/$(word 1, $(subst @,:,$(IMAGE)))

$(foreach image,$(IMAGES),$(image)\print): ## Print container image
	$(eval IMAGE := $(subst \, ,$@))
	@echo $(word 1, $(subst @,:,$(IMAGE)))
