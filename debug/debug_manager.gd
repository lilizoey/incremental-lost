extends Node

var debug_enabled: bool = false

func _process(delta):
	if Input.is_action_just_pressed("debug"):
		debug_enabled = not debug_enabled
		if debug_enabled:
			print("debug enabled")
		else:
			print("debug disabled")
