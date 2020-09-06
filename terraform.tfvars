#setup 
api_list = [
  "cloudresourcemanager",
  "container"
]

#gke confing val
gke_cluster_name = "bks-k8s"
region           = "europe-west"
zone             = "europe-west1-c"
project_id       = "bks-infra"
node_count       = 1
auto_upgrade     = true
machine_type     = "e2-small"
disk_size_gb     = "40"

#helm deployment
environment_variables = {
  namespace = "vault"
}

consul_helmfile_content = {
  "releases" : [
    {
      "name" : "consul-vault",
      "namespace" : "vault",
      "chart" : "hashicorp/consul",
      "version" : "0.24.1",
      "wait" : true,
      "values" : [
        "./resources/values_templates/vault_consul_values.yaml.gotmpl"
      ]

    }
  ]
}

vault_helmfile_content = {
  "releases" : [
    {
      "name" : "vault",
      "namespace" : "vault",
      "chart" : "hashicorp/vault",
      "version" : "0.7.0",
      "wait" : true,
      "values" : [
        "./resources/values_templates/vault_values.yaml.gotmpl"
      ]
    }
  ]
}