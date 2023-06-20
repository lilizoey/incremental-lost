extends Node

const TAG_DISPLAY := {
	"eats" = "items requiring nutrition",
}

func to_display(tag: String) -> String:
	var display = TAG_DISPLAY.get(tag)
	
	if display:
		return display
	else:
		return tag
