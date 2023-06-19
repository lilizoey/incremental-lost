extends Requirement

@export var requirements: Array[Requirement] = []

func is_fulfilled() -> bool:
	for requirement in requirements:
		if requirement.is_fulfilled():
			return true
	
	return false
