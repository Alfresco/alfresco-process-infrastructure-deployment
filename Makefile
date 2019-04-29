DOCKER_REGISTRY := $(or $(DOCKER_REGISTRY),$(APS_REGISTRY_HOST))

IMAGES := alpine@3.8 \
jboss/keycloak@4.8.3.Final \
alfresco/alfresco-keycloak-theme@0.1 \
postgres@10.1

.PHONY: $(IMAGES) 

values-registry.yaml: images values

test:
	test $(DOCKER_REGISTRY)

login: test
	docker login quay.io
	docker login $(DOCKER_REGISTRY)

pull: $(foreach image,$(IMAGES),$(image)\pull)

tag: $(foreach image,$(IMAGES),$(image)\tag)

push: $(foreach image,$(IMAGES),$(image)\push)

print: $(foreach image,$(IMAGES),$(image)\print)

images: test pull tag push

values: test
	@envsubst < values-registry.tmpl > values-registry.yaml
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
