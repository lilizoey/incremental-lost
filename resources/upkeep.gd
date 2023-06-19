@tool
class_name Upkeep extends Resource

enum ConsumptionType {
	SpecificResource,
	ResourceCategory,
	ResourceTag,
}

@export var consumption_type: ConsumptionType = ConsumptionType.SpecificResource:
	set(new_type):
		consumption_type = new_type
		notify_property_list_changed()
@export var consumption_per_day: float = 1.0

var specific_resource: ItemResource
var resource_tag

func _get_property_list():
	var properties: Array[Dictionary] = []
	
	match consumption_type:
		ConsumptionType.SpecificResource:
			properties.append({
				"name" = "specific_resource",
				"type" = TYPE_OBJECT,
				"hint" = PROPERTY_HINT_TYPE_STRING,
				"hint_string" = "%s:ItemResource" % [TYPE_OBJECT],
				"usage" = PROPERTY_USAGE_DEFAULT
			})
		ConsumptionType.ResourceCategory:
			properties.append({
				"name" = "resource_category",
				"type" = TYPE_INT,
				"hint" = PROPERTY_HINT_ENUM,
				"hint_string" = "RawMaterial,Material,Food,Refuse,People",
				"usage" = PROPERTY_USAGE_DEFAULT
			})
		ConsumptionType.ResourceTag:
			properties.append({
				"name" = "resource_tag",
				"type" = TYPE_NIL,
				"usage" = PROPERTY_USAGE_DEFAULT
			})
	
	return properties

func perform_upkeep():
	match consumption_type:
		ConsumptionType.SpecificResource:
			upkeep_specific_resource()
		ConsumptionType.ResourceCategory:
			upkeep_resource_category()
		ConsumptionType.ResourceTag:
			upkeep_resource_tag()

func upkeep_specific_resource():
	push_error("unimplemented")

func upkeep_resource_category():
	return
	#var resources: Array[ItemResource] = Resources.resources.filter(func (resource):
	#	return resource.category == resource_category and resource.amount > 0.0
	#)
	
	#var to_consume: float = consumption_per_day
	#var target_consume = 0.0 
	
	#while to_consume > 0.01:
	#	target_consume = to_consume / resources.size()
	#	
	#	if resources.is_empty():
	#		push_error("no valid resources to upkeep")
	#		return
	#	
	#	for resource in resources:
	#		var consuming = min(resource.amount, target_consume)
	#		resource.amount -= consuming
	#		to_consume -= consuming

func upkeep_resource_tag():
	push_error("unimplemented")
