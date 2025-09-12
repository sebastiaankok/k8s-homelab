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

## 🐧 NixOS Configurations

This repo also manages my **NixOS fleet** using flakes, keeping everything reproducible and declarative:

- **Main host (📦 B660 + i5-13600)** → runs k3s cluster workloads, microVMs, and ArgoCD-managed apps.
- **Laptop (💻 Dell i5-7300U)** → my development machine with a full workstation profile (Home Manager, Neovim, Nixvim).
- **Raspberry Pi 4 (🍓 ser2net)** → lightweight edge device for serial↔MQTT bridging.

### 🔑 Features
- **Flakes everywhere** → pinned inputs for deterministic builds.
- **Secrets with `sops-nix`** → no secrets in Git, age/GPG-backed.
- **MicroVM support** → lightweight VMs directly managed by Nix.
- **Home Manager** → consistent user environments across devices.
- **Nixvim integration** → Neovim fully configured via Nix modules (LSP, treesitter, telescope, etc.).

This way, both my **infrastructure (k8s)** and my **developer experience (NixOS + Neovim)** are fully reproducible and version-controlled in one repo.

---

## <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f331/512.gif" alt="🌱" width="20" height="20"> GitOps Layout

```sh
📁 k8s
└── 📁 k3s-home
    └── 📁 argocd
        ├── 📁 databases
        │   └── 📁 cnpg-operator
        │       └── application.yaml
        ├── 📁 downloads
        │   ├── 📁 bazarr
        │   ├── 📁 jellyseerr
        │   ├── 📁 prowlarr
        │   ├── 📁 radarr
        │   ├── 📁 sabnzbd
        │   └── 📁 sonarr
        ├── 📁 home-automation
        │   ├── 📁 home-assistant
        │   ├── 📁 kamstrup-mqtt
        │   ├── 📁 mosquitto
        │   └── 📁 zigbee2mqtt
        ├── 📁 media
        │   ├── 📁 immich
        │   └── 📁 jellyfin
        ├── 📁 monitoring
        ├── 📁 network
        │   └── 📁 wol-proxy
        ├── 📁 nvr
        │   └── 📁 frigate
        └── 📁 system
            ├── 📁 cert-manager
            ├── 📁 ingress-nginx
            ├── 📁 ingress-nginx-media
            └── 📁 velero
```

---

## ✅ Conventions & Notes

- Each app directory contains an ArgoCD Application manifest (or a Helm chart reference) and environment-specific overlays if needed.
- Keep cluster-level bootstrap manifests (ArgoCD installation, Secrets, Cilium installation) at [nix-homelab](https://github.com/sebastiaankok/nix-homelab).
- Prefer immutable image tags in apps; use Renovate to propose updates.
- Use Nix flakes for reproducible host configs; keep flake inputs committed to the repo.

---

## 🙏 Thanks

Thanks to the HomeOps community and all open-source projects used in this setup.

