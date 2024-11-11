# cloudrun-grpc-health

## set up terraform

### login google

```sh
gcloud auth application-default login
```

### set project

```sh
gcloud config set project cloudrun-grpc-health
```

### auth ArtifactRegistry

```sh
gcloud auth configure-docker asia-northeast1-docker.pkg.dev
```

### enable APIs

```sh
gcloud services enable run.googleapis.com
```
