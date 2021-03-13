# Terraform @ Google Cloud
1. Download & install the terraform CLI <https://www.terraform.io/downloads.html>
2. Setup gcloud project and get credentials <https://cloud.google.com/community/tutorials/getting-started-on-gcp-with-terraform> - see <main.tf>
3. Run `terraform init`:
```plaintext
thomas@DESKTOP:~/github.com/ghouscht/tsbe-paas-demo/iac$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/google...
- Installing hashicorp/google v3.59.0...
- Installed hashicorp/google v3.59.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!
```

4. Run `terraform plan` and then `terraform apply`
5. Start an ssh-agent:
```bash
eval $(ssh-agent)
ssh-add id_rsa
```

5. Login to gateway and verify ssh agent forwarding:
```
export GATEWAY=$(terraform output gateway | cut -d\" -f2)
ssh -A student@$GATEWAY
ssh-add -l
```