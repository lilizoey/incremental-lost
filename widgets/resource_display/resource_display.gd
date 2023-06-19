extends VBoxContainer

const CATEGORY_SCENE: PackedScene = preload("res://widgets/resource_display/resource_category_list.tscn")
const COUNT_SCENE: PackedScene = preload("res://widgets/resource_display/resource_count.tscn")

func _ready():
	var categories := Resources.get_categories()
	
	categories.sort_custom(func (a,b): a.display_name <= b.display_name)
	
	for category in categories:
		var resources: Array[ItemResource] = Resources.get_resources_from_category(category)
		
		var label: ResourceCategoryLabel = CATEGORY_SCENE.instantiate()
		label.call_deferred("initialize", category)
		add_child(label)
