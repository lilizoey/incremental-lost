class_name ResourceSpecificAmount extends ResourceAmount
# Track a specific resource.

@export var resource: ItemResource

func _get_resources() -> Array[ItemResource]:
	if resource:
		return [resource]
	else:
		return []

func as_cost() -> String:
	if resource:
		return resource.display_name
	else:
		return super.as_cost()
