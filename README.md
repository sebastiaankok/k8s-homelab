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

## ser2net

```yaml
connection: &con01
  enable: on
  accepter: tcp,20108
  connector: serialdev,/dev/serial/by-id/usb-ITead_Sonoff_Zigbee_3.0_USB_Dongle_Plus_da3c386a8212ec11915520c7bd930c07-if00-port0,115200n81,local,dtr=off,rts=off
  options:
    kickolduser: true

connection: &con02
  accepter: tcp,20208
  connector: serialdev,/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_AB4HWRSK-if00-port0,115200n81,local
  options:
    kickolduser: true
    banner: *banner
    telnet-brk-on-sync: true

connection: &con03
  accepter: tcp,20308
  connector: serialdev,/dev/serial/by-id/usb-RFXCOM_RFXtrx433XL_DO7372CL-if00-port0,38400n81,local
  options:
    kickolduser: true
    telnet-brk-on-sync: true

connection: &con04
  accepter: tcp,20408
  connector: serialdev,/dev/serial/by-id/usb-Silicon_Labs_CP2102_USB_to_UART_Bridge_Controller_0001-if00-port0,9600n81,local
  options:
    kickolduser: true
    banner: *banner
    telnet-brk-on-sync: true
```
