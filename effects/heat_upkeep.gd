extends Effect

const HEAT_RESOURCE: ItemResource = preload("res://resources/item_resources/environment/heat.tres")
const HEAT_TAG := "requires_heat"

var tag_amount: ResourceAmount = generate_tag_amount()

func generate_tag_amount() -> ResourceTagAmount:
	var amount := ResourceTagAmount.new()
	amount.any_tags = [HEAT_TAG]
	return amount

func on_day_changed(_new_day: int):
	var heat_needed := get_heat_needed()
	var left := HEAT_RESOURCE.try_remove(heat_needed)
	if left > 0.0:
		push_warning("couldn't heat everyone, missing ", left, " heat")

func get_heat_needed() -> float:
	return tag_amount.get_amount(func (resource: ItemResource):
		var amount := resource.amount
		var amount_mod := resource.get_tag_float(HEAT_TAG, 1.0)
		return amount * amount_mod
	)
