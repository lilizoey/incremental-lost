extends TabContainer

var unlocked_tabs: int = 0

func _ready():
	for child_idx in get_child_count():
		var child = get_child(child_idx)
		
		if child.has_signal("tab_unlocked"):
			child.connect("tab_unlocked", _on_tab_unlocked.bind(child_idx))
			set_tab_hidden(child_idx, true)
		else:
			unlocked_tabs += 1
	
	tabs_visible = unlocked_tabs > 1

func _on_tab_unlocked(child_idx):
	unlocked_tabs += 1
	set_tab_hidden(child_idx, false)
	tabs_visible = unlocked_tabs > 1
