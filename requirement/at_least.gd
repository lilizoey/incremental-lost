class_name RequirementAtLeast extends Requirement

@export var resource: ResourceAmount
@export var minimum_amount: float = 0.0

func is_fulfilled() -> bool:
	return resource.get_amount() >= minimum_amount

func as_cost() -> String:
	return "%.2f %s" % [minimum_amount, resource.as_cost()]
