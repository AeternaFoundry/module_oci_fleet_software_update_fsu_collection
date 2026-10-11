variable "fleet_software_update_fsu_collections" {
  description = <<EOT
Map of fleet_software_update_fsu_collections, attributes below
Required:
    - compartment_id
    - service_type
    - type
Optional:
    - defined_tags
    - display_name
    - freeform_tags
    - source_major_version
    - components (block):
        - component_type (required)
        - fleet_discovery (optional, block):
            - filters (optional, block):
                - entity_type (optional)
                - exadata_releases (optional)
                - identifiers (optional)
                - mode (optional)
                - operator (optional)
                - tags (optional, block):
                    - key (optional)
                    - namespace (optional)
                    - value (optional)
                - type (required)
                - versions (optional)
            - fsu_discovery_id (optional)
            - query (optional)
            - strategy (required)
            - targets (optional)
        - source_major_version (required)
    - fleet_discovery (block):
        - filters (optional, block):
            - entity_type (optional)
            - exadata_releases (optional)
            - identifiers (optional)
            - mode (optional)
            - names (optional)
            - operator (optional)
            - tags (optional, block):
                - key (optional)
                - namespace (optional)
                - value (optional)
            - type (required)
            - versions (optional)
        - fsu_discovery_id (optional)
        - query (optional)
        - strategy (required)
        - targets (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    compartment_id       = string
    service_type         = string
    type                 = string
    defined_tags         = optional(map(string))
    display_name         = optional(string)
    freeform_tags        = optional(map(string))
    source_major_version = optional(string)
    components = optional(list(object({
      component_type = string
      fleet_discovery = optional(object({
        filters = optional(list(object({
          entity_type      = optional(string)
          exadata_releases = optional(list(string))
          identifiers      = optional(list(string))
          mode             = optional(string)
          operator         = optional(string)
          tags = optional(list(object({
            key       = optional(string)
            namespace = optional(string)
            value     = optional(string)
          })))
          type     = string
          versions = optional(list(string))
        })))
        fsu_discovery_id = optional(string)
        query            = optional(string)
        strategy         = string
        targets          = optional(list(string))
      }))
      source_major_version = string
    })))
    fleet_discovery = optional(object({
      filters = optional(list(object({
        entity_type      = optional(string)
        exadata_releases = optional(list(string))
        identifiers      = optional(list(string))
        mode             = optional(string)
        names            = optional(list(string))
        operator         = optional(string)
        tags = optional(list(object({
          key       = optional(string)
          namespace = optional(string)
          value     = optional(string)
        })))
        type     = string
        versions = optional(list(string))
      })))
      fsu_discovery_id = optional(string)
      query            = optional(string)
      strategy         = string
      targets          = optional(list(string))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.fleet_software_update_fsu_collections : (
        contains([for v in ["DB", "EXADB_STACK", "GI", "GUEST_OS"] : lower(v)], lower(v.type))
      )
    ])
    error_message = "must be one of: \"DB\", \"EXADB_STACK\", \"GI\", \"GUEST_OS\""
  }
  validation {
    condition = alltrue([
      for k, v in var.fleet_software_update_fsu_collections : (
        v.components == null || alltrue([for item in v.components : (contains([for v in ["GI", "GUEST_OS"] : lower(v)], lower(item.component_type)))])
      )
    ])
    error_message = "must be one of: \"GI\", \"GUEST_OS\""
  }
  validation {
    condition = alltrue([
      for k, v in var.fleet_software_update_fsu_collections : (
        v.components == null || alltrue([for item in v.components : (item.fleet_discovery == null || (contains([for v in ["DISCOVERY_RESULTS", "FILTERS", "SEARCH_QUERY", "TARGET_LIST"] : lower(v)], lower(item.fleet_discovery.strategy))))])
      )
    ])
    error_message = "must be one of: \"DISCOVERY_RESULTS\", \"FILTERS\", \"SEARCH_QUERY\", \"TARGET_LIST\""
  }
  validation {
    condition = alltrue([
      for k, v in var.fleet_software_update_fsu_collections : (
        v.components == null || alltrue([for item in v.components : (item.fleet_discovery == null || (item.fleet_discovery.filters == null || alltrue([for item in item.fleet_discovery.filters : (contains([for v in ["COMPARTMENT_ID", "DEFINED_TAG", "EXADATA_RELEASE_VERSION", "FREEFORM_TAG", "RESOURCE_ID", "VERSION"] : lower(v)], lower(item.type)))])))])
      )
    ])
    error_message = "must be one of: \"COMPARTMENT_ID\", \"DEFINED_TAG\", \"EXADATA_RELEASE_VERSION\", \"FREEFORM_TAG\", \"RESOURCE_ID\", \"VERSION\""
  }
  validation {
    condition = alltrue([
      for k, v in var.fleet_software_update_fsu_collections : (
        v.fleet_discovery == null || (contains([for v in ["DISCOVERY_RESULTS", "FILTERS", "SEARCH_QUERY", "TARGET_LIST"] : lower(v)], lower(v.fleet_discovery.strategy)))
      )
    ])
    error_message = "must be one of: \"DISCOVERY_RESULTS\", \"FILTERS\", \"SEARCH_QUERY\", \"TARGET_LIST\""
  }
  validation {
    condition = alltrue([
      for k, v in var.fleet_software_update_fsu_collections : (
        v.fleet_discovery == null || (v.fleet_discovery.filters == null || alltrue([for item in v.fleet_discovery.filters : (contains([for v in ["COMPARTMENT_ID", "DB_HOME_NAME", "DB_NAME", "DB_UNIQUE_NAME", "DEFINED_TAG", "EXADATA_RELEASE_VERSION", "FREEFORM_TAG", "RESOURCE_ID", "VERSION"] : lower(v)], lower(item.type)))]))
      )
    ])
    error_message = "must be one of: \"COMPARTMENT_ID\", \"DB_HOME_NAME\", \"DB_NAME\", \"DB_UNIQUE_NAME\", \"DEFINED_TAG\", \"EXADATA_RELEASE_VERSION\", \"FREEFORM_TAG\", \"RESOURCE_ID\", \"VERSION\""
  }
}

