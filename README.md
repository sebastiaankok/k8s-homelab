# k8s-homelab

Repository for managing my k8s homelab

## Bootstrap ArgoCD core

Applying the manifest will install ArgoCD core and repository-controller

```
kubectl apply --kustomize clusters/k8s-home/bootstrap
```

## References helm charts

- [bjw-s/helm-charts](https://bjw-s.github.io/helm-charts)
- [cloudnative-pg](https://cloudnative-pg.io/charts/)
- [helm.cilium.io](https://helm.cilium.io/)
- [argo-cd](https://raw.githubusercontent.com/argoproj/argo-cd/v2.10.1/manifests/core-install.yaml)
- [kubernetes/ingress-nginx](https://kubernetes.github.io/ingress-nginx)
- [charts.jetstack.io](https://charts.jetstack.io)
- [rancher/local-path-provisioner](https://github.com/rancher/local-path-provisioner.git)
- [nextcloud/helm](https://nextcloud.github.io/helm/)


## References image repositories

- [ghcr.io/cloudnative-pg](https://ghcr.io/cloudnative-pg)
- [public.ecr.aws/docker/library/eclipse-mosquitto](https://public.ecr.aws/docker/library/eclipse-mosquitto)
- [ghcr.io/koenkk/zigbee2mqtt](https://ghcr.io/koenkk/zigbee2mqtt)
- [rhasspy/wyoming-whisper](https://rhasspy/wyoming-whisper)
- [ghcr.io/home-assistant](https://ghcr.io/home-assistant)
- [rclone/rclone](https://rclone/rclone)
- [ghcr.io/onedr0p](https://ghcr.io/onedr0p)
- [ghcr.io/recyclarr/recyclarr](https://ghcr.io/recyclarr/recyclarr)
- [ghcr.io/sct/overseerr](https://ghcr.io/sct/overseerr)
