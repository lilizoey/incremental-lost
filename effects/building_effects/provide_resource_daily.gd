class_name BuildingProvideResourceDaily extends BuildingEffect

@export var result: Result

func on_day_changed(_new_day: int):
	if not result:
		push_warning("no result set")
		return
	
	if amount == 0:
		return
	
	result.perform(amount)
