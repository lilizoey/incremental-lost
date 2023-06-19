class_name ResourceCategoryAmount extends ResourceAmount
# Track all resources of a category.

@export var category: ResourceCategory

func _get_resources() -> Array[ItemResource]:
	if not category:
		push_warning("no category selected")
		return []
	return Resources.get_resources_from_category(category)

