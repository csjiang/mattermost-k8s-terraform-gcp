# mattermost-k8s-terraform-gcp
personal mattermost server infrastructure and config-as-code.

## develop
### prerequisites
* [Docker](https://docs.docker.com/get-docker/)
* [gcloud account + project with compute engine enabled](https://cloud.google.com/)
* gcloud credentials through [cli auth](https://cloud.google.com/sdk/gcloud/reference/auth/login) or [creds json exported as env var](https://cloud.google.com/docs/authentication/getting-started). If you are using a JSON credentials file, it should live in the root of this project directory so that it can be found when mounting project dir to dev container as a volume.

```bash
$ git clone git@github.com:csjiang/mattermost-k8s-terraform-gcp.git && cd mattermost-k8s-terraform-gcp
$ scripts/start-dev-container.sh
```