extends Label

func _ready():
	TimeManager.day_changed.connect(_on_day_changed)

func _on_day_changed(new_day: int):
	text = str(new_day)
