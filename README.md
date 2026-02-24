# Homelab

## Manual Setup
Ideally there will be nothing here eventually

- K3s install
- Set nonsudo read permission on default k3s kubeconfig:
    - `sudo chmod 604 /etc/rancher/k3s/k3s.yaml`
- `echo "alias k='kubectl'" >> ~/.bashrc`
- `echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc`

## Todos
### MVP
- [X] Terraform provision Cloudflare initial setup
- [X] Terraform [SOPS](https://getsops.io/) (Secure Operations) provider
- [ ] Script-based SOPS secret management
- [ ] SOPS git pre-commit hook 
- [ ] Write Ansible k3s setup playbooks
- [ ] Setup helm
- [ ] Kubernetes setup argoCD
- [ ] Kubernetes host Vaultwarden 
- [ ] Kubernetes setup cert-manager
- [ ] Kubernetes backup
    - [ ] Velero for etcd and cluster persistent volume backups
    - [ ] Terraform provision AWS S3 bucket for backups

### Future
- [ ] Terraform [Atlantis](https://www.runatlantis.io/) gitops
- [ ] Migrate SOPS secret management to a cloud provider 
- [ ] Prometheus + Grafana Monitoring
    - [ ] Kubernetes Cluster
    - [ ] Vaultwarden service
- [ ] Investigate using TalOS for kubernetes
- [ ] Host Static Site
    - [ ] Terraform provision AWS cloudfront (use CNAME in cloudflare)
    - [ ] Terraform provision S3 bucket to host content from
    - [ ] AWS cert manager
