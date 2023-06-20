class_name ResourceAmount extends Resource

const AMOUNT_LEEWAY: float = 0.001

# Get the resources this tracker tracks.
func _get_resources() -> Array[ItemResource]:
	push_error("unimplemented")
	return []

# Get the amount of resources tracked.
#
# If amount_func is a valid callable, it will be called on each `ItemResource` to
# and the amount returned by the callable will be used instead of the raw amount.
func get_amount(amount_func := Callable()) -> float:
	var resources := _get_resources()
	var amount := 0.0
	
	for resource in resources:
		if amount_func.is_valid():
			amount += amount_func.call(resource)
		else:
			amount += resource.amount
	
	return amount

# Remove an amount of resources from this amount tracker.
#
# Returns the amount we were unable to remove.
#
# if allow negative is true, then it will bring resources that can be made negative
# to negative values.
#
# if prioritize_positive is true then it will only bring resources that can be made negative, 
# negative when there are no positive ones left.
func remove_amount(
	amount: float, 
	allow_negative: bool = false, 
	prioritize_positive: bool = true,
	) -> float:
	var resources := _get_resources()
	var positive_resources := _filter_positive(resources)
	var maybe_negative_resources := resources.filter(
		func (resource: ItemResource): resource.may_be_negative()
	)
	
	var left := amount
	while left > AMOUNT_LEEWAY:
		if not positive_resources.is_empty() \
			and (not allow_negative or prioritize_positive):
			left = _remove_amount_from(
				left / positive_resources.size(),
				positive_resources,
			)
			positive_resources = _filter_positive(positive_resources)
		elif allow_negative and not maybe_negative_resources.is_empty():
			left = _remove_amount_from(
				left / maybe_negative_resources.size(),
				maybe_negative_resources,
				true
			)
			# We can always remove resources from possibly negative resources
		else:
			return left
	
	return 0.0

# Try to remove `target_each` from each resource in `resources`.
#
# Return what was unable to be removed.
func _remove_amount_from(
	target_each: float, 
	resources: Array[ItemResource],
	allow_negative: bool = false,
	) -> float:
	var left := 0.0
	for resource in resources:
		left += resource.try_remove(target_each, allow_negative)
	return left

# Returns an array containing only the resources from `arr` that have positive amounts.
func _filter_positive(arr: Array[ItemResource]) -> Array[ItemResource]:
	return arr.filter(
		func (resource: ItemResource): return resource.amount > 0.0
	)

# Return a string representing this amount for usage in costs.
func as_cost() -> String:
	return "## undefined ##"
