class_name ResourceCategoryLabel extends VBoxContainer

signal initialized

const RESOURCE_COUNT_SCENE: PackedScene = preload("res://widgets/resource_display/resource_count.tscn")

var category: ResourceCategory
# String -> float
var daily_expected_effects := {}

@export var collapse_button: Button
@export var name_label: Label
@export var effect_label: Label
@export var resource_list: VBoxContainer

var is_initialized: bool = false

func initialize(category: ResourceCategory):
	self.category = category
	visible = false
	
	is_initialized = true
	initialized.emit()

func _ready():
	for child in resource_list.get_children():
		child.queue_free()
	
	collapse_button.toggled.connect(_on_collapse_toggled)
	
	if not is_initialized:
		await initialized
	
	name_label.text = category.display_name
	
	update_visibility()
	
	var resources := Resources.get_resources_from_category(category)
	resources.sort_custom(func (a,b): return a.display_name <= b.display_name)
	for resource in resources:
		var resource_count: ResourceCounter = RESOURCE_COUNT_SCENE.instantiate()
		resource_count.initialize(resource)
		
		resource_list.add_child(resource_count)

func _process(delta):
	if not is_initialized:
		return
	
	update_visibility()
	var expected_effect := category.calculate_daily_expected_effect()
	update_effect_display(expected_effect)

func _on_collapse_toggled(pressed: bool):
	$Resources.visible = pressed

func update_visibility():
	if visible:
		return
	
	for resource in Resources.get_resources_from_category(category):
		if resource.is_unlocked():
			visible = true
			return

func update_effect_display(expected_effect: float):
	if expected_effect == 0.0:
		effect_label.visible = false
		return
	
	effect_label.visible = true
	if expected_effect > 0.0:
		effect_label.text = "+%.2f" % expected_effect
		effect_label.theme_type_variation = "PositiveLabel"
	else:
		effect_label.text = "-%.2f" % abs(expected_effect)
		effect_label.theme_type_variation = "NegativeLabel"

