class_name WeightedResult extends Result

@export var resource: ItemResource
@export var weighted: Array[WeightedAmount]

func perform(multiplier: float = 1.0):
	var total: int = 0
	
	for weight in weighted:
		total += weight.weight
	
	var r := randi_range(0, total - 1)
	
	var acc: int = 0
	
	for weight in weighted:
		acc += weight.weight
		if acc > r:
			resource.amount += multiplier * randi_range(weight.amount_min, weight.amount_max)
			return
