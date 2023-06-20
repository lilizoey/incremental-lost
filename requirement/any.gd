class_name RequirementAny extends Requirement

@export var requirements: Array[Requirement] = []

func is_fulfilled() -> bool:
	for requirement in requirements:
		if requirement.is_fulfilled():
			return true
	
	return false

func as_cost() -> String:
	var costs := []
	for requirement in requirements:
		costs.append(requirement.as_cost())
	
	return str(
		"any of:\n\t",
		",\n\t".join(PackedStringArray(costs))
	)
