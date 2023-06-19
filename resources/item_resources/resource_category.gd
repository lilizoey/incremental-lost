class_name ResourceCategory extends Resource

@export var display_name: String = ""
@export var internal_name: String = ""

# String -> float
var daily_expected_effects := {}

func set_daily_expected_effect(key: String, amount: float):
	daily_expected_effects[key] = amount

func remove_daily_expected_effect(key: String):
	daily_expected_effects.erase(key)

func calculate_daily_expected_effect() -> float:
	var total := 0.0
	for effect in daily_expected_effects.values():
		total += effect
	return total
