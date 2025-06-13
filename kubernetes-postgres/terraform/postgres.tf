resource "stackit_postgresflex_instance" "my_db_instance" {
  project_id      = var.project_id
  name            = "my-db-instance"
  acl             = stackit_ske_cluster.my_ske.egress_address_ranges
  backup_schedule = "00 00 * * *"
  flavor          = { cpu = 2, ram = 4 }
  replicas        = 1
  storage         = { class = "premium-perf2-stackit", size = 5 }
  version         = 17
}


resource "stackit_postgresflex_user" "my_db_user" {
  project_id  = var.project_id
  instance_id = stackit_postgresflex_instance.my_db_instance.instance_id
  username    = "my_db_user"
  roles       = ["login", "createdb"]
}

resource "stackit_postgresflex_database" "my_db" {
  project_id  = var.project_id
  instance_id = stackit_postgresflex_instance.my_db_instance.instance_id
  owner       = stackit_postgresflex_user.my_db_user.username
  name        = "my-db"
}
