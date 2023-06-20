extends HFlowContainer

signal tab_unlocked

var is_tab_unlocked := false

func _ready():
	for child in get_children():
		if child.has_signal("unlocked"):
			child.connect("unlocked", _on_child_unlocked)

func _on_child_unlocked():
	if not is_tab_unlocked:
		is_tab_unlocked = true
		tab_unlocked.emit()
