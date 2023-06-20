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

func as_cost() -> String:
	if any_tags.is_empty() and all_tags.is_empty():
		return "anything"
	
	if any_tags.size() == 1 and all_tags.is_empty():
		return TagsManager.to_display(any_tags[0])
	
	if all_tags.size() == 1 and any_tags.is_empty():
		return TagsManager.to_display(all_tags[0])
	
	if all_tags.size() == 1 and any_tags.size() == 1:
		return "both %s, and %s" % [TagsManager.to_display(any_tags[0]), TagsManager.to_display(all_tags[0])]
	
	var any_display := ""
	if not any_tags.is_empty():
		any_display = "items that are any of: ("
		var any_arr: Array[String] = []
		
		for tag in any_tags:
			any_arr.append(TagsManager.to_display(tag))
		
		any_display += ",".join(PackedStringArray(any_arr))
		any_display += ")"
	
	var all_display := ""
	if not all_tags.is_empty():
		all_display = "items that are all of: ("
		var all_arr: Array[String] = []
		
		for tag in all_tags:
			all_arr.append(TagsManager.to_display(tag))
		
		all_display += ",".join(PackedStringArray(all_arr))
		all_display += ")"
	
	if not all_display.is_empty() and not any_display.is_empty():
		return str(all_display, " and ", any_display)
	elif not all_display.is_empty():
		return all_display
	elif not any_display.is_empty():
		return any_display
	else:
		push_error("unreachable")
		return "err"
