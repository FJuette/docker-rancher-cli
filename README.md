## Docker-rancher-cli 2.x image

This container is a simple wrapper for the rancher-cli 2.x (**not** 1.x) (see https://github.com/rancher/cli)

### Basic usage

To use this image directly run
```bash
docker run -it --rm fjuette/rancher-cli bash
```

In the container first login into rancher using
```bash
rancher login <RANCHER_URL> -t <RANCHER_BEARER_TOKEN>
```
and choose your project.

Or you can specify the project id with the *--context* paremeter. (e.g. c-vttdp:p-5c4mh)
```bash
rancher login <RANCHER_URL> -t <RANCHER_BEARER_TOKEN> --context <RANCHER_CONTEXT>
# rancher login rancher.example.com -t token-a1b2c:a8bbclhc123p4sash5qtavxrx76bjp7srwk99b7ph8q132cbt5rjc8 --context c-vttdp:p-1a2bc
```

### Example usage in .gitlab-ci.yml

I use this image to update my container in my rancher k8s cluster.
*$RANCHER_URL* and *$RANCHER_TOKEN* are set as CI/CD variables in gitlab project settings.

In this example the *rancher kubectl patch ...* command is using a tricky way to update a deployment in the k8s cluster without changing the docker image tag.

```yaml
deploy:
  stage: deploy
  image: fjuette/docker-rancher-cli
  script:
    - rancher login $RANCHER_URL -t $RANCHER_TOKEN --context c-vttdp:p-1a2bc
    - rancher kubectl patch deployment hiwi-ng -p "{\"spec\":{\"template\":{\"metadata\":{\"labels\":{\"date\":\"`date +'%s'`\"}}}}}"
  only:
    - master
```

