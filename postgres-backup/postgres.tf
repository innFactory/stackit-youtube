resource "stackit_postgresflex_instance" "abc_db_instance" {
  project_id      = var.project_id
  name            = "abc-db-instance"
  acl             = ["0.0.0.0/0"] // full access for testing purposes only, do not use in production
  backup_schedule = "0 14 * * *"
  flavor          = { cpu = 2, ram = 4 }
  replicas        = 1
  storage         = { class = "premium-perf2-stackit", size = 5 }
  version         = 17
}


resource "stackit_postgresflex_user" "abc_db_user" {
  project_id  = var.project_id
  instance_id = stackit_postgresflex_instance.abc_db_instance.instance_id
  username    = "abc_db_user"
  roles       = ["login", "createdb"]
}

resource "stackit_postgresflex_database" "abc_db" {
  project_id  = var.project_id
  instance_id = stackit_postgresflex_instance.abc_db_instance.instance_id
  owner       = stackit_postgresflex_user.abc_db_user.username
  name        = "abc-db"
}
