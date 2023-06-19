extends Requirement

@export var requirements: Array[Requirement] = []

func is_fulfilled() -> bool:
	for requirement in requirements:
		if not requirement.is_fulfilled():
			return false
	
	return true
