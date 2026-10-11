resource "oci_fleet_software_update_fsu_collection" "fleet_software_update_fsu_collections" {
  for_each = var.fleet_software_update_fsu_collections

  compartment_id       = each.value.compartment_id
  service_type         = each.value.service_type
  type                 = each.value.type
  defined_tags         = each.value.defined_tags
  display_name         = each.value.display_name
  freeform_tags        = each.value.freeform_tags
  source_major_version = each.value.source_major_version

  dynamic "components" {
    for_each = each.value.components != null ? each.value.components : []
    content {
      component_type = components.value.component_type
      dynamic "fleet_discovery" {
        for_each = components.value.fleet_discovery != null ? [components.value.fleet_discovery] : []
        content {
          dynamic "filters" {
            for_each = fleet_discovery.value.filters != null ? fleet_discovery.value.filters : []
            content {
              entity_type      = filters.value.entity_type
              exadata_releases = filters.value.exadata_releases
              identifiers      = filters.value.identifiers
              mode             = filters.value.mode
              operator         = filters.value.operator
              dynamic "tags" {
                for_each = filters.value.tags != null ? filters.value.tags : []
                content {
                  key       = tags.value.key
                  namespace = tags.value.namespace
                  value     = tags.value.value
                }
              }
              type     = filters.value.type
              versions = filters.value.versions
            }
          }
          fsu_discovery_id = fleet_discovery.value.fsu_discovery_id
          query            = fleet_discovery.value.query
          strategy         = fleet_discovery.value.strategy
          targets          = fleet_discovery.value.targets
        }
      }
      source_major_version = components.value.source_major_version
    }
  }

  dynamic "fleet_discovery" {
    for_each = each.value.fleet_discovery != null ? [each.value.fleet_discovery] : []
    content {
      dynamic "filters" {
        for_each = fleet_discovery.value.filters != null ? fleet_discovery.value.filters : []
        content {
          entity_type      = filters.value.entity_type
          exadata_releases = filters.value.exadata_releases
          identifiers      = filters.value.identifiers
          mode             = filters.value.mode
          names            = filters.value.names
          operator         = filters.value.operator
          dynamic "tags" {
            for_each = filters.value.tags != null ? filters.value.tags : []
            content {
              key       = tags.value.key
              namespace = tags.value.namespace
              value     = tags.value.value
            }
          }
          type     = filters.value.type
          versions = filters.value.versions
        }
      }
      fsu_discovery_id = fleet_discovery.value.fsu_discovery_id
      query            = fleet_discovery.value.query
      strategy         = fleet_discovery.value.strategy
      targets          = fleet_discovery.value.targets
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

