class_name Building extends Resource

@export var display_name: String = ""
@export var internal_name: String = ""
@export var unlock_criteria: UnlockCriteria

func update(delta: float):
	if unlock_criteria:
		unlock_criteria.update(delta)

