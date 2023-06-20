class_name RequirementAtMost extends Requirement

@export var resource: ResourceAmount
@export var maximum_amount: float = 0.0

func is_fulfilled() -> bool:
	return resource.get_amount() <= maximum_amount

func as_cost() -> String:
	return "at most %.2f of %s" % [maximum_amount, resource.as_cost()]
