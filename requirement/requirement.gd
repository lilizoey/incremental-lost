class_name Requirement extends Resource

func is_fulfilled() -> bool:
	push_error("unimplemented")
	return false

func consume_cost():
	push_error("unimplemented")

func as_cost() -> String:
	return "## undefined ##"
