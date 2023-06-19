class_name GlobalEffectNode extends Node

@export var effect: Effect

func _ready():
	TimeManager.time_changed.connect(_on_time_changed)
	TimeManager.day_changed.connect(_on_day_changed)

func _process(delta):
	if effect:
		effect.update_expectations()
	else:
		push_warning("no effect selected")

func _on_time_changed(delta: float, new_time: float):
	if effect:
		effect.on_time_changed(delta, new_time)
	else:
		push_warning("no effect selected")

func _on_day_changed(new_day: int):
	if effect:
		effect.on_day_changed(new_day)
	else:
		push_warning("no effect selected")
