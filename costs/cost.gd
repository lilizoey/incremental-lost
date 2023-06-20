class_name Cost extends Resource

@export var resource_amounts: Array[CostAmount] = []

func is_fulfilled() -> bool:
	for amount in resource_amounts:
		if not amount.is_fulfilled():
			return false
	return true

func consume() -> bool:
	if not is_fulfilled():
		return false
	
	for amount in resource_amounts:
		amount.consume()
	
	return true

func _to_string() -> String:
	var arr := []
	
	for cost in resource_amounts:
		arr.append(str(cost))
	
	return "cost: %s" % [", ".join(PackedStringArray(arr))]
