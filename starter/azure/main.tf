data "azurerm_resource_group" "udacity" {
  name     = "Regroup_1xMGkah0K7jexQJMXR"
}

resource "azurerm_container_group" "udacity" {
  name                = "udacity-continst"
  location            = data.azurerm_resource_group.udacity.location
  resource_group_name = data.azurerm_resource_group.udacity.name
  ip_address_type     = "Public"
  dns_name_label      = "udacity-juanc-azure"
  os_type             = "Linux"

  container {
    name   = "azure-container-app"
    image  = "docker.io/tscotto5/azure_app:1.0"
    cpu    = "0.5"
    memory = "1.5"
    environment_variables = {
      "AWS_S3_BUCKET"       = "udacity-juanc-aws-s3-bucket",
      "AWS_DYNAMO_INSTANCE" = "udacity-juanc-aws-dynamodb"
    }
    ports {
      port     = 3000
      protocol = "TCP"
    }
  }
  tags = {
    environment = "udacity"
  }
}

####### Your Additions Will Start Here ######

resource "azurerm_mssql_server" "udacity" {
  name                         = "udacity-juanc-azure-sql"
  resource_group_name          = data.azurerm_resource_group.udacity.name
  
  
}

resource "azurerm_function_app" "udacity" {
  name                       = "udacity-juanc-azure-dotnet-apps"
  resource_group_name        = data.azurerm_resource_group.udacity.name
}