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

- **NixOS (flake-based)** for declarative host management
- **k3s** as the lightweight Kubernetes distribution
- **ArgoCD** for continuous reconciliation of Kubernetes manifests

Primary workloads include **home automation, media, downloads, databases, networking, and system services** — all managed declaratively under `./k8s/k3s-home/argocd`.

---

## 🐧 NixOS Fleet

Beyond Kubernetes, this repo also manages my **NixOS machines** with flakes, ensuring everything is reproducible:

- **Main host (⚓ B660 + i5-13600)** → runs the k3s cluster, microVMs, and ArgoCD apps
- **Laptop (💻 Dell i5-7300U)** → development machine with workstation profile (Home Manager + Nixvim)
- **Raspberry Pi 4 (ser2net)** → lightweight edge device for serial ↔ MQTT bridging

---

## 🔑 Key Features

- **Deterministic builds** with pinned flake inputs
- **Secret management** via `sops-nix` (no secrets in Git)
- **MicroVM support** for lightweight VMs directly in Nix
- **Home Manager** for consistent user environments
- **Nixvim-powered Neovim** with LSP, treesitter, telescope, and more

With this setup, both my **infrastructure (k8s)** and my **developer experience (NixOS + Neovim)** live in a **single, version-controlled repo**.

---

## ⌨ Neovim Configuration

This repository also manages my **Neovim setup** declaratively through [nixvim](https://github.com/nix-community/nixvim), giving me a fully reproducible development environment:

- **Plugin management via Nix**:
  - **LSP support** (`lsp.nix`) for intelligent code completions and diagnostics
  - **Treesitter** syntax highlighting and parsing (`treesitter.nix`)
  - **Telescope** fuzzy finder (`telescope.nix`)
  - **Git integration** with `gitsigns.nix` and `gitblame.nix`
  - **Productivity enhancements** like `autopairs.nix`, `todo-comments.nix`, `trouble.nix`, and `which-key.nix`
  - **UI/UX improvements** with `lualine.nix`, `neo-tree.nix`, `colorizer.nix`, and `markview.nix`
  - **LLM assistance** via `avante.nix`

With this setup, Neovim behaves consistently across all NixOS hosts, and updates are **fully reproducible via flakes**. Every plugin and configuration is version-controlled, ensuring that my editor is portable and crash-proof.

---

## <img src="https://fonts.gstatic.com/s/e/notoemoji/latest/1f331/512.gif" alt="📜" width="20" height="20"> GitOps Layout

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
- Keep cluster-level bootstrap manifests (ArgoCD installation, Secrets, Cilium installation) at [nixos-microvm](https://github.com/sebastiaankok/home-ops/tree/main/modules/virtual/k3s-home).
- Prefer immutable image tags in apps; use Renovate to propose updates.
- Use Nix flakes for reproducible host configs; keep flake inputs committed to the repo.

---

## 🙏 Acknowledgements

This setup takes inspiration from the **HomeOps community** and builds on great projects like:
- [bjw-s-labs/helm-charts](https://github.com/bjw-s-labs/helm-charts)
- [nix-community/nixvim](https://github.com/nix-community/nixvim)
- [whazor/k8s-at-home-search](https://github.com/whazor/k8s-at-home-search)
