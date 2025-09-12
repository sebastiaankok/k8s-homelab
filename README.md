<div align="center">

<img src="https://raw.githubusercontent.com/kubernetes/kubernetes/master/logo/logo.png" align="center" width="144px" height="144px"/>

### <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f680/512.gif" alt="🚀" width="16" height="16"> My Home Ops Repository <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f6a7/512.gif" alt="🚧" width="16" height="16">

_... managed with ArgoCD, NixOS, and k3s_ <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f916/512.gif" alt="🤖" width="16" height="16">

</div>

<div align="center">

[![ArgoCD](https://img.shields.io/badge/GitOps-ArgoCD-blue?logo=argo&logoColor=white&style=for-the-badge)](https://argo-cd.readthedocs.io)&nbsp;&nbsp;
[![Kubernetes](https://img.shields.io/badge/Kubernetes-k3s-blue?logo=kubernetes&logoColor=white&style=for-the-badge)](https://k3s.io)&nbsp;&nbsp;
[![NixOS](https://img.shields.io/badge/OS-NixOS-blue?logo=nixos&logoColor=white&style=for-the-badge)](https://nixos.org)&nbsp;&nbsp;

</div>

---

## 💡 Overview

This repository contains my **GitOps-driven homelab** powered by:

- **NixOS** (flake-based) for declarative host management
- **k3s** as the lightweight Kubernetes distribution
- **ArgoCD** for continuous reconciliation of Kubernetes manifests

Primary workloads: home automation, media, downloads, databases, networking and system services — all managed declaratively under `./clusters/k8s-home/argocd/apps`.

---

## <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f331/512.gif" alt="🌱" width="20" height="20"> GitOps Layout

```sh
📁 clusters
└── 📁 k8s-home
    ├── 📁 argocd
    │   ├── 📁 apps
    │   │   ├── 📁 databases
    │   │   │   └── 📁 cnpg-operator
    │   │   ├── 📁 home-automation
    │   │   │   ├── 📁 mosquitto
    │   │   │   ├── 📁 kamstrup-mqtt
    │   │   │   ├── 📁 zigbee2mqtt
    │   │   │   └── 📁 home-assistant
    │   │   ├── 📁 network
    │   │   │   └── 📁 wol-proxy
    │   │   ├── 📁 system
    │   │   │   ├── 📁 velero
    │   │   │   ├── 📁 cert-manager
    │   │   │   ├── 📁 ingress-nginx
    │   │   │   └── 📁 ingress-nginx-media
    │   │   ├── 📁 downloads
    │   │   │   ├── 📁 bazarr
    │   │   │   ├── 📁 prowlarr
    │   │   │   ├── 📁 sabnzbd
    │   │   │   ├── 📁 radarr
    │   │   │   ├── 📁 sonarr
    │   │   │   └── 📁 jellyseerr
    │   │   ├── 📁 nvr
    │   │   │   └── 📁 frigate
    │   │   └── 📁 media
    │   │       ├── 📁 jellyfin
    │   │       └── 📁 immich
```

## 🧱 Hardware

- **Main host**: Gigabyte B660M — 13th Gen Intel® Core™ i5-13600, **64 GB RAM**, **2 TB SSD** + **20 GB HDD**
- **Edge**: Raspberry Pi 4 — **8 GB** (for edge/arm workloads)

---

## ✅ Conventions & Notes

- Each app directory contains an ArgoCD Application manifest (or a Helm chart reference) and environment-specific overlays if needed.
- Keep cluster-level bootstrap manifests (ArgoCD installation, Secrets, Cilium installation) at [nix-homelab](https://github.com/sebastiaankok/nix-homelab).
- Prefer immutable image tags in apps; use Renovate to propose updates.
- Use Nix flakes for reproducible host configs; keep flake inputs committed to the repo.

---

## 🙏 Thanks

Thanks to the HomeOps community and all open-source projects used in this setup.

