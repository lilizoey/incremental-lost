class_name RequirementAll extends Requirement

@export var requirements: Array[Requirement] = []

func is_fulfilled() -> bool:
	for requirement in requirements:
		if not requirement.is_fulfilled():
			return false
	
	return true

func as_cost() -> String:
	var costs := []
	for requirement in requirements:
		costs.append(requirement.as_cost())
	
	return str(
		", ".join(PackedStringArray(costs))
	)
