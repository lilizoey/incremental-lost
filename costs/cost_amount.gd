class_name CostAmount extends Resource

@export var item: ItemResource
@export var amount: int = 1

func is_fulfilled() -> bool:
	if item.may_be_negative():
		return true
	else:
		return amount <= item.amount

func consume() -> bool:
	if not is_fulfilled():
		return false
	
	item.try_remove(amount, true)
	
	return true

func _to_string() -> String:
	return "%s %s" %[amount, item.display_name]
