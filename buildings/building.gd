class_name Building extends Resource

@export var display_name: String = ""
@export var internal_name: String = ""
@export var unlock_criteria: UnlockCriteria
@export var effects: Array[BuildingEffect] = []
@export var construction_cost: Cost

var amount := 0:
	set(new_amount):
		for effect in effects:
			effect.amount = new_amount
		amount = new_amount

func on_time_changed(delta: float, new_time: float):
	if unlock_criteria:
		unlock_criteria.update(delta)
	
	for effect in effects:
		effect.on_time_changed(delta, new_time)

func on_day_changed(new_day: int):
	for effect in effects:
		effect.on_day_changed(new_day)

func is_fulfilled() -> bool:
	return construction_cost.is_fulfilled()

func consume_costs() -> bool:
	return construction_cost.consume()

func on_construct():
	amount += 1
	for effect in effects:
		effect.on_construct()
