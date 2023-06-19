extends Node

const DAY_LENGTH: float = 60.0
var speed: float = 1.0

var days_passed: int = 0
var time_passed: float = 0.0

signal time_changed(delta: float, new_time: float)
signal day_changed(new_day: int)

func _process(delta: float):
	time_passed += delta * speed
	if time_passed > DAY_LENGTH:
		time_passed -= DAY_LENGTH
		days_passed += 1
		time_changed.emit(delta * speed, time_passed)
		day_changed.emit(days_passed)
	else:
		time_changed.emit(delta * speed, time_passed)

func time_absolute_to_frac(absolute: float) -> float:
	return absolute / DAY_LENGTH

func time_absolute_to_percent(absolute: float) -> float:
	return time_absolute_to_frac(absolute) * 100.0

func time_frac_to_absolute(frac: float) -> float:
	return frac * DAY_LENGTH

func time_percent_to_absolute(percent: float) -> float:
	return time_frac_to_absolute(percent / 100.0)

func _unhandled_key_input(event):
	if not DebugManager.debug_enabled:
		return
	if event is InputEventKey:
		if event.pressed:
			var old_speed = speed
			match event.key_label:
				KEY_1:
					speed = 1
				KEY_2:
					speed = 3
				KEY_3:
					speed = 5
				KEY_4:
					speed = 10
				KEY_5:
					speed = 25
				KEY_6:
					speed = 50
			
			if old_speed != speed:
				print("speed is ", speed)
