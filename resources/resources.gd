@tool
extends Node

@export var categories: Array[ResourceCategory] = []:
	set(new_categories):
		categories = new_categories
		for category in categories:
			if not category:
				continue
			if not categories_dict.has("category_" + category.internal_name):
				categories_dict[category.internal_name] = []
		notify_property_list_changed()
var categories_dict: Dictionary = {}
var resources_dict: Dictionary = {}

func _ready():
	if Engine.is_editor_hint():
		return
	
	for category in categories_dict:
		for resource in categories_dict[category]:
			resources_dict[resource.name] = resource

func get_resource(name: String) -> ItemResource:
	return resources_dict.get(name)

func get_all_resources() -> Array[ItemResource]:
	var arr: Array[ItemResource] = []
	arr.assign(resources_dict.values())
	return arr

func get_categories() -> Array[ResourceCategory]:
	return categories

func get_resources_from_category(category: ResourceCategory) -> Array[ItemResource]:
	var items: Array[ItemResource] = []
	items.assign(categories_dict.get("category_" + category.internal_name))
	return items

func _set(prop: StringName, value: Variant) -> bool:
	if not prop.begins_with("category_"):
		return false
	
	categories_dict[prop] = value
	
	return true

func _get(prop: StringName):
	if not prop.begins_with("category_"):
		return null
	
	return categories_dict.get(prop)

func _get_property_list():
	var properties: Array[Dictionary] = []
	
	for category in categories:
		if not category:
			continue
		properties.append({
			"name" = "category_" + category.internal_name,
			"type" = TYPE_ARRAY,
			"hint" = PROPERTY_HINT_TYPE_STRING,
			"hint_string" = "%s/%s:ItemResource" % [TYPE_OBJECT, PROPERTY_HINT_RESOURCE_TYPE],
			"usag" = PROPERTY_USAGE_DEFAULT
		})
	
	return properties
