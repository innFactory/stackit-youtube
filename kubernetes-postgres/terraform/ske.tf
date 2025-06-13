resource "stackit_ske_cluster" "my_ske" {
  project_id             = var.project_id
  name                   = "my-ske"
  kubernetes_version_min = "1.32.5"
  node_pools = [
    {
      name               = "mypool"
      machine_type       = "c1.2"
      os_name            = "flatcar"
      minimum            = "1"
      maximum            = "1"
      availability_zones = ["eu01-1"]
      volume_type        = "storage_premium_perf1"
    }
  ]
  maintenance = {
    enable_kubernetes_version_updates    = true
    enable_machine_image_version_updates = true
    start                                = "01:00:00Z"
    end                                  = "02:00:00Z"
  }
}
