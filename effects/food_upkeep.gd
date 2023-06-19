extends Effect

const FOOD_CATEGORY: ResourceCategory = preload("res://resources/item_resources/food_category.tres")
const EAT_TAG := "eats"
const FOOD_MOD_TAG := "food_mod"

var tag_amount: ResourceAmount = generate_tag_amount()
var food_amount: ResourceAmount = generate_food_amount()

func generate_tag_amount() -> ResourceTagAmount:
	var amount := ResourceTagAmount.new()
	amount.any_tags = [EAT_TAG]
	return amount

func generate_food_amount() -> ResourceCategoryAmount:
	var amount := ResourceCategoryAmount.new()
	amount.category = FOOD_CATEGORY
	return amount

func on_day_changed(_new_day: int):
	var food_needed := get_food_needed()
	var left := food_amount.remove_amount(food_needed)
	if left > 0.0:
		push_warning("couldn't feed everyone, missing ", left, " food")

func update_expectations():
	FOOD_CATEGORY.set_daily_expected_effect("food_upkeed", -get_food_needed())

func get_food_needed() -> float:
	return tag_amount.get_amount(func (resource: ItemResource):
		var amount := resource.amount
		var amount_mod := resource.get_tag_float(FOOD_MOD_TAG, 1.0)
		return amount * amount_mod
	)
