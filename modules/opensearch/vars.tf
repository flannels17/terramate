variable "domain" {
  type        = string
  description = "The name of the cluster"
}

variable "engine_version" {
  type        = string
  description = "The engine version of OpenSearch cluster"
}

variable "aws_account_id" {
  type = string
}

variable "hot_instance_type" {
  type        = string
  description = "The instance_type used for the cluster"

  validation {
    condition = contains([
      "m5.large.search",
      "m5.xlarge.search",
      "m5.2xlarge.search",
      "m5.4xlarge.search",
      "m5.12xlarge.search",
      "m6g.large.search",
      "m6g.xlarge.search",
      "m6g.2xlarge.search",
      "m6g.4xlarge.search",
      "m6g.8xlarge.search",
      "m6g.12xlarge.search",
      "t3.small.search",
      "t3.medium.search"
      ],
      var.hot_instance_type
    )

    error_message = "Only the following general purpose instance types are supported: T3, M5 and M6g"
  }
}

variable "hot_instance_count" {
  type        = number
  description = "The amount of data nodes"
}

variable "ebs_volume_size" {
  type        = number
  description = "The volume size of the ebs volume"
}

variable "dedicated_master_config" {
  type = object({
    enabled               = optional(bool, false)
    master_instance_count = optional(number, 3)
    master_instance_type  = optional(string, "m6g.large.search")
  })

  default = {}

  validation {
    condition = contains([
      "m5.large.search",
      "m6g.large.search",
      "c5.2xlarge.search",
      "c6g.2xlarge.search",
      "r5.xlarge.search",
      "r6g.xlarge.search",
      "r5.2xlarge.search",
      "r6g.2xlarge.search",
      "r5.4xlarge.search",
      "r6g.4xlarge.search"],
      var.dedicated_master_config.master_instance_type
    )
    error_message = "Only the following instances are allowed: https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-dedicatedmasternodes.html"

  }

  validation {
    condition     = contains([0, 3], var.dedicated_master_config.master_instance_count)
    error_message = "AWS is forcing us to have 3 master nodes, See: https://docs.aws.amazon.com/opensearch-service/latest/developerguide/managedomains-dedicatedmasternodes.html"
  }
}

variable "warm_storage_config" {
  type = object({
    enabled       = optional(bool, false)
    storage_type  = optional(string, "ultrawarm1.medium.search")
    storage_count = optional(number, 2)
  })

  default = {}

  validation {
    condition     = contains(["ultrawarm1.medium.search", "ultrawarm1.large.search"], var.warm_storage_config.storage_type)
    error_message = "The following are the only valid values for warm storage: ultrawarm1.medium.search, ultrawarm1.large.search"
  }

  validation {
    condition     = var.warm_storage_config.storage_count >= 2 && var.warm_storage_config.storage_count <= 150
    error_message = "Warm storage node count must be between 2 and 150"
  }
}

variable "cold_storage_enabled" {
  type        = bool
  description = "Whether to enable the cold storage or not"
  default     = null
}

variable "availability_zones" {
  type        = number
  description = "The number of availability zones for the cluster"
  default     = 1

  validation {
    condition     = contains([1, 2, 3], var.availability_zones)
    error_message = "Valid values are 1,2 or 3"
  }
}

variable "standby_enabled" {
  type        = bool
  description = "Whether to enable multi AZ standby or not"
  default     = false
}

variable "master_role_arn" {
  type        = string
  description = "The arn of the Cloudops tooling SSO role"
}

variable "saml_enabled" {
  type        = bool
  description = "Whether to enable SAML or not"
  default     = false
}

variable "saml_entity_id" {
  type        = string
  description = "The unique Entity ID of the application in SAML Identity Provider"
  default     = null
}

variable "saml_metadata_content" {
  type        = string
  description = "The metadata of the SAML application in xml format"
  default     = ""
}

variable "saml_backend_role" {
  type        = string
  description = "This backend role from the SAML IdP receives full permissions to the cluster"
  default     = ""
}

variable "saml_roles_key" {
  type        = string
  description = "Element of the SAML assertion to use for backend roles"
  default     = ""
}

variable "vpc_enabled" {
  type        = bool
  description = "Whether to launch opensearch within a VPC or not"
  default     = false
}

variable "vpc_id" {
  type        = string
  description = "The Vpc ID"
  default     = ""
}

variable "subnet_ids" {
  type        = list(string)
  description = "A list of subnet ids"
  default     = []
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "Allowed cidrs in security group"
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "List of tags"
}

variable "sqs-log-queues" {
  type        = list(string)
  description = "list with sqs queues for triggering corresponding es-loader lambda"
}

variable "log-buckets" {
  type        = list(string)
  description = "List with bucket names of buckets containing logs to be ingested by es-loader lambdas"
}

variable "kms_arns" {
  type        = list(string)
  description = "List of KMS key ARN's to which the es-loader IAM role will have the ability to decrypt"
}

variable "managed-policies-es-loader" {
  type        = list(string)
  description = "List with the arns of aws managed policies needed for es-loader role"

}
