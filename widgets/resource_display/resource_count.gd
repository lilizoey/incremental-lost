class_name ResourceCounter extends HBoxContainer

signal initialized

var resource: ItemResource
@export var name_node: Label
@export var amount_node: Label

var is_initialized := false

func initialize(resource: ItemResource):
	self.resource = resource
	is_initialized = true
	initialized.emit()

func _ready():
	if not is_initialized:
		await initialized
	
	name_node.text = resource.display_name

func _process(delta):
	if not is_initialized:
		return
	
	amount_node.text = str(resource.amount)
	visible = resource.is_unlocked()
