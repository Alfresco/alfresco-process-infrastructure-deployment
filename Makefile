DOCKER_REGISTRY := $(or $(DOCKER_REGISTRY),$(REGISTRY_HOST))
VALUES_REGISTRY_TMPL := $(or $(VALUES_REGISTRY_TMPL), values-registry.tmpl)

.EXPORT_ALL_VARIABLES:

ALPINE_TAG := 3.8
KEYCLOAK_TAG := 4.8.3.Final
KEYCLOAK_THEME_TAG := 0.1
POSTGRES_TAG := 11.3
ALFRESCO_DIGITAL_WORKSPACE_TAG := 1.1.0
AAE_TAG := 2.3.0
NFS_PROVISIONER_TAG := v2.2.1-k8s1.12
DIND_TAG := 18.06.1-dind
MINIDEB_EXTRAS_TAG := stretch
ALFRESCO_AI_DOCKER_ENGINE_TAG := 1.0.1
INSIGHT_ENGINE_TAG := 1.1.0.1
ALFRESCO_SEARCH_SERVICES_TAG := 1.3.0.4
ALFRESCO_SHARED_FILE_STORE_TAG := 0.5.3
ALFRESCO_IMAGEMAGICK_TAG := 2.0.17
ALFRESCO_LIBREOFFICE_TAG := 2.0.17
ALFRESCO_PDF_RENDERER_TAG := 2.0.17
ALFRESCO_CONTENT_REPOSITORY_TAG := 6.1.0
ALFRESCO_SHARE_TAG := 6.1.0
ALFRESCO_TIKA_TAG := 2.0.17
ALFRESCO_TRANSFORM_ROUTER_TAG := 1.0.2.1
ALFRESCO_ACTIVEMQ_TAG := 5.15.8-java-8-oracle-centos-7-87b15e37ce8b

IMAGES := alpine@$(ALPINE_TAG) \
jboss/keycloak@$(KEYCLOAK_TAG) \
alfresco/alfresco-keycloak-theme@$(KEYCLOAK_THEME_TAG) \
postgres@$(POSTGRES_TAG) \
bitnami/minideb-extras@${MINIDEB_EXTRAS_TAG} \
docker@${DIND_TAG} \
quay.io/kubernetes_incubator/nfs-provisioner@${NFS_PROVISIONER_TAG} \
alfresco/alfresco-search-services@${ALFRESCO_SEARCH_SERVICES_TAG} \
alfresco/alfresco-shared-file-store@${ALFRESCO_SHARED_FILE_STORE_TAG} \
alfresco/alfresco-content-repository@${ALFRESCO_CONTENT_REPOSITORY_TAG} \
alfresco/alfresco-share@${ALFRESCO_SHARE_TAG} \
alfresco/alfresco-activemq@${ALFRESCO_ACTIVEMQ_TAG} \
quay.io/alfresco/alfresco-ai-docker-engine@${ALFRESCO_AI_DOCKER_ENGINE_TAG} \
quay.io/alfresco/insight-engine@${INSIGHT_ENGINE_TAG} \
quay.io/alfresco/alfresco-imagemagick@${ALFRESCO_IMAGEMAGICK_TAG} \
quay.io/alfresco/alfresco-libreoffice@${ALFRESCO_LIBREOFFICE_TAG} \
quay.io/alfresco/alfresco-pdf-renderer@${ALFRESCO_PDF_RENDERER_TAG} \
quay.io/alfresco/alfresco-tika@${ALFRESCO_TIKA_TAG} \
quay.io/alfresco/alfresco-transform-router@${ALFRESCO_TRANSFORM_ROUTER_TAG} \
quay.io/alfresco/alfresco-digital-workspace@$(ALFRESCO_DIGITAL_WORKSPACE_TAG) \
quay.io/alfresco/alfresco-admin-app@${AAE_TAG} \
quay.io/alfresco/alfresco-deployment-service@${AAE_TAG} \
quay.io/alfresco/alfresco-modeling-app@${AAE_TAG} \
quay.io/alfresco/alfresco-modeling-service@${AAE_TAG} \
quay.io/alfresco/alfresco-dmn-service@${AAE_TAG}

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
