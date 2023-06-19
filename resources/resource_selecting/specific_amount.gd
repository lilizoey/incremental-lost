extends ResourceAmount
# Track a specific resource.

@export var resource: ItemResource

func _get_resources() -> Array[ItemResource]:
	if resource:
		return [resource]
	else:
		return []
