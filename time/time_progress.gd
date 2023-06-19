extends ProgressBar

func _ready():
	TimeManager.time_changed.connect(_on_time_changed)

func _on_time_changed(delta: float, new_time: float):
	var time_percent: float = 100.0 * new_time / TimeManager.DAY_LENGTH
	value = time_percent
