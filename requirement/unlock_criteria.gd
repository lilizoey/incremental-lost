class_name UnlockCriteria extends Resource

signal unlocked

@export var unlock_criteria: Requirement

var is_unlocked: bool = false

# how frequently (in frames) to check unlock criteria
const CHECK_EVERY: int = 30
var check_on_frame: int = 0
var i: int = 0

func _init():
	check_on_frame = randi_range(0, CHECK_EVERY -  1)

func update(_delta: float):
	check_unlocked()

func check_unlocked():
	if not unlock_criteria:
		is_unlocked = true
	
	if is_unlocked:
		return
	
	i += 1
	if i % CHECK_EVERY == check_on_frame:
		if unlock_criteria.is_fulfilled():
			is_unlocked = true
			unlocked.emit()
