#!/usr/bin/env bash

provider="lm_studio"
model="qwen3-coder-30b-a3b-instruct"
#provider="openrouter"
#model="qwen/qwen3-coder:free"
#model="anthropic/claude-3.7-sonnet"

# Directory containing NixOS container configurations
nix_containers_dir="$HOME/projects/nix-homelab/modules/containers"
k8s_apps_dir="$HOME/projects/k8s-homelab/clusters/k8s-home/argocd/apps"

instructions="# NixOS to Kubernetes Migration Instructions

I need to migrate services from my NixOS configuration to Kubernetes.
The Kubernetes YAML files already exist but need to be updated to match the current NixOS configuration.

## Migration Rules:
1. PRESERVE all metadata (name, namespace, labels) in Kubernetes files
2. MATCH the container image version between NixOS and Kubernetes
3. CONFIGURE storage paths correctly:
   - NixOS uses: appData = config.hostConfig.dataDir + \"\${app}\"
   - config.hostConfig.dataDir = /data/
   - Ensure hostPath in storage-hostpath.yaml matches this pattern
4. ADD device mounts ONLY for USB or GPU devices when needed
5. IGNORE ingress and domain name configurations

## Device Mount Example:
```yaml
persistence:
  config:
    enabled: true
    type: hostPath
    hostPath: /dev
```

ONLY modify files that have been explicitly added to this context."

# Loop through each service directory in the NixOS containers directory
for service_dir in "$nix_containers_dir"/*; do
  # Extract just the service name from the path
  service=$(basename "$service_dir")

  echo -e "\n\033[1;36m=== Processing service: $service ===\033[0m"

  if [ ! -d "$service_dir" ]; then
    continue
  fi

  # Find the NixOS configuration file for this service
  ro_file="$(find "$service_dir" -type f -name "default.nix")"

  if [ -z "$ro_file" ]; then
    echo -e "\033[1;33m⚠️  Could not find default.nix for service $service, skipping...\033[0m"
    continue
  fi

  # Find corresponding Kubernetes YAML files
  k8s_files=$(find "$k8s_apps_dir" -type f -name "*.yaml" | grep "$service" | grep 'values.yaml\|storage-hostpath.yaml')

  if [ -z "$k8s_files" ]; then
    echo -e "\033[1;33m⚠️  No matching Kubernetes files found for service $service, skipping...\033[0m"
    continue
  fi

  echo -e "\033[0;32m✓ Found NixOS config:\033[0m $ro_file"
  echo -e "\033[0;32m✓ Found K8s files:\033[0m"
  echo "$k8s_files" | sed 's/^/  - /'

  # Process each Kubernetes file
  while read -r write_file; do
    echo -e "\n\033[1;34m→ Migrating:\033[0m $write_file"
    echo -e "\033[0;90m  Running aider to update Kubernetes configuration...\033[0m"

    yes no | aider --model $provider/$model \
          --chat-language english --no-auto-commits \
          --no-show-model-warnings \
          --no-detect-urls \
          --read "$ro_file" \
          --message "$instructions" \
          --file "$write_file"

    migration_status=$?
    if [ $migration_status -eq 0 ]; then
      echo -e "\033[1;32m✓ Migration completed for file\033[0m"
    else
      echo -e "\033[1;31m✗ Migration failed for file\033[0m"
    fi

    # # -- Review
    # yes | no aider --model lm_studio/qwen3-coder-30b-a3b-instruct --dark-mode \
    #       --chat-language english --commit-language dutch --no-auto-commits \
    #       --no-show-model-warnings \
    #       --yes-always \
    #       --map-tokens 0 \
    #       --no-detect-urls \
    #       --read "$readonly_files" \
    #       --message "You are a reviewer of code. Are the instructions from $instructions_file applied correctly? Also check the git diff: $(git diff $write_file)" \
    #       --read "$instructions_file" \
    #
  done <<< "$k8s_files"

  echo -e "\n\033[1;32m✅ Completed migration for service: $service\033[0m"
  echo -e "\033[1;36m================================================\033[0m"
done
