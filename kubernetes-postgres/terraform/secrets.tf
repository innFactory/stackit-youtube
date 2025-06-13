provider "kubernetes" {
  config_context = "my-ske"
  config_path    = "my-ske.yml"
}


resource "kubernetes_secret" "postgres_connection" {
  metadata {
    name      = "postgres-connection"
    namespace = "default"
  }

  data = {
    username = stackit_postgresflex_user.my_db_user.username
    password = stackit_postgresflex_user.my_db_user.password
    host     = stackit_postgresflex_user.my_db_user.host
    port     = stackit_postgresflex_user.my_db_user.port
    name     = stackit_postgresflex_database.my_db.name
  }
}
