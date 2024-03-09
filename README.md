# Azure kube-toolchain

Simple use as a container

```
docker run -it --rm  -u "$(id -u):$(id -g)" -v ~/.azure:/home/user/.azure  -v ~/.kube:/home/user/.kube --rm --network=host --workdir /home/user ghcr.io/nandor-magyar/az-kube-toolchain:latest
```

