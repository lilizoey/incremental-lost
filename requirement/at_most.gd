extends Requirement

@export var resource: ResourceAmount
@export var maximum_amount: float = 0.0

func is_fulfilled() -> bool:
	return resource.get_amount() <= maximum_amount
