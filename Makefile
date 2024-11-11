ENV ?= dev

# 環境ごとの設定
ifeq ($(ENV), dev)
    TERRAFORM_DIR = terraform/environments/dev
    GOOGLE_PROJECT_ID = cloudrun-grpc-health
    GOOGLE_PROJECT_REGION = asia-northeast1
endif

.PHONY: terraform-init
terraform-init:
	terraform -chdir=$(TERRAFORM_DIR) init

.PHONY: terraform-plan
terraform-plan:
	terraform -chdir=$(TERRAFORM_DIR) plan

.PHONY: terraform-apply
terraform-apply:
	terraform -chdir=$(TERRAFORM_DIR) apply

.PHONY: docker-tag
docker-tag:
	docker tag cloudrun-grpc-health-service:latest $(GOOGLE_PROJECT_REGION)-docker.pkg.dev/$(GOOGLE_PROJECT_ID)/repository/cloudrun-grpc-health-service:latest

.PHONY: docker-push
docker-push:
	docker push $(GOOGLE_PROJECT_REGION)-docker.pkg.dev/$(GOOGLE_PROJECT_ID)/repository/cloudrun-grpc-health-service:latest

.PHONY: gcloud-deploy
gcloud-deploy:
	gcloud run services replace ./infra/$(ENV).yaml --project=$(GOOGLE_PROJECT_ID) --region=$(DEV_GOOGLE_PROJECT_REGION)
