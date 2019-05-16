DOCKER_REGISTRY := $(or $(DOCKER_REGISTRY),$(APS_REGISTRY_HOST))
VALUES_REGISTRY_TMPL := $(or $(VALUES_REGISTRY_TMPL), values-registry.tmpl)

.EXPORT_ALL_VARIABLES:

ALPINE_TAG := 3.8
KEYCLOAK_TAG := 4.8.3.Final
KEYCLOAK_THEME_TAG := 0.1
POSTGRES_TAG := 10.1
ADW_TAG := 1.1.0

IMAGES := alpine@$(ALPINE_TAG) \
jboss/keycloak@$(KEYCLOAK_TAG) \
alfresco/alfresco-keycloak-theme@$(KEYCLOAK_THEME_TAG) \
postgres@$(POSTGRES_TAG) \
quay.io/alfresco/alfresco-digital-workspace@$(ADW_TAG)

.PHONY: $(IMAGES) 

all: images values

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

values: 
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
