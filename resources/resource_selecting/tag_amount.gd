class_name ResourceTagAmount extends ResourceAmount
# Tracks resources that have any of the tags in `any_tags` and all the tags in `all_tags`.
# If `any_tags` is empty, then it is ignored.

@export var any_tags: Array[String] = []
@export var all_tags: Array[String] = []


func _get_resources() -> Array[ItemResource]:
	var all_resources := Resources.get_all_resources()
	return all_resources.filter(filter_tags)

func filter_tags(resource: ItemResource) -> bool:
	var has_any := false
	
	if any_tags.is_empty():
		has_any = true
	else:
		for tag in any_tags:
			if resource.has_tag(tag):
				has_any = true
				break
	
	if not has_any:
		return false
	
	return resource.has_all_tags(all_tags)
