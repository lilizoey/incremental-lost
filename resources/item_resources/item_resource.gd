@tool
class_name ItemResource
extends Resource

@export var display_name: String = ""
@export var name: String = ""
@export_multiline var description: String = ""
@export var amount: float = 0.0:
	set(new_amount):
		if new_amount < 0.0 and not may_be_negative():
			amount = 0.0
		else:
			amount = new_amount
@export var category: ResourceCategory

## unlocking
var unlocked: bool = false:
	set(new_unlocked):
		unlocked = new_unlocked
		notify_property_list_changed()
# if unlocked is false
var auto_unlock: bool = true:
	set(new_auto):
		auto_unlock = new_auto
		notify_property_list_changed()
# if auto unlock is true
var auto_unlock_at: float = 1.0
var auto_unlock_minimum: bool = true

## maximum
var has_maximum: bool = false:
	set(new_has):
		has_maximum = new_has
		notify_property_list_changed()
# if has_maximum is true
var maximum_amount: float = 1.0

# String -> float
var daily_expected_effects: Dictionary = {}

@export var tags: Dictionary = {}

func is_unlocked() -> bool:
	if unlocked:
		return true
	
	if not auto_unlock:
		return false
	
	if auto_unlock_minimum:
		return amount >= auto_unlock_at
	else:
		return amount <= auto_unlock_at
	

func _get_property_list():
	var properties: Array[Dictionary] = []
	
	properties.append({
		"name" = "unlocked",
		"type" = TYPE_BOOL,
		"usage" = PROPERTY_USAGE_DEFAULT
	})
	
	if not unlocked:
		properties.append({
			"name" = "auto_unlock",
			"type" = TYPE_BOOL,
			"usage" = PROPERTY_USAGE_DEFAULT
		})
		
	if not unlocked and auto_unlock:
		properties.append({
			"name" = "auto_unlock_at",
			"type" = TYPE_FLOAT,
			"usage" = PROPERTY_USAGE_DEFAULT
		})
		properties.append({
			"name" = "auto_unlock_minimum",
			"type" = TYPE_BOOL,
			"usage" = PROPERTY_USAGE_DEFAULT
		})
	
	properties.append({
		"name" = "has_maximum",
		"type" = TYPE_BOOL,
		"usage" = PROPERTY_USAGE_DEFAULT
	})
	
	if has_maximum:
		properties.append({
			"name" = "maximum_amount",
			"type" = TYPE_FLOAT,
			"usage" = PROPERTY_USAGE_DEFAULT
		})
	
	return properties

func _property_can_revert(property):
	if property in [
		"unlocked", 
		"auto_unlock", 
		"auto_unlock_at", 
		"auto_unlock_minimum", 
		"has_maximum", 
		"maximum_amount"
	]:
		return true

func _property_get_revert(property):
	match property:
		"unlocked","has_maximum":
			return false
		"auto_unlock","auto_unlock_minimum":
			return true
		"auto_unlock_at":
			return 1.0
		"maximum_amount":
			return 100.0
	


# Try to remove an amount from this resource.
#
# Return extra that wasn't able to be removed.
#
# If the resource may be negative and allow negative is true, then this may reduce the amount to
# below 0.0.
func try_remove(amount: float, allow_negative: bool = false) -> float:
	if amount < 0.0:
		push_warning("got negative amount in try_remove")
	
	if may_be_negative() and allow_negative:
		self.amount -= amount
		return 0.0
	
	if self.amount <= 0.0:
		return amount
	
	self.amount -= amount
	
	if self.amount < 0.0:
		var extra = abs(self.amount)
		self.amount = 0.0
		return extra
	
	return 0.0

func may_be_negative() -> bool:
	return tags.has("negative_allowed")

func has_tag(tag: String) -> bool:
	return tags.has(tag)

func has_all_tags(tags: Array[String]) -> bool:
	return self.tags.has_all(tags)

func get_tag_float(tag: String, default: float = 0.0) -> float:
	return tags.get(tag, default)

func set_daily_expected_effect(key: String, amount: float):
	daily_expected_effects[key] = amount

func remove_daily_expected_effect(key: String):
	daily_expected_effects.erase(key)

func calculate_daily_expected_effect() -> float:
	var total := 0.0
	for effect in daily_expected_effects.values():
		total += effect
	return total
