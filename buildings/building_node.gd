extends PanelContainer

signal unlocked
signal constructed

@export var display_name: String = ""
@export var building: Building
@export var percent_of_day_taken: float = 100.0

@export var name_label: Label
@export var amount_label: Label
@export var cost_label: Label
@export var progress_bar: ProgressBar
@export var button: Button

var time_taken_absolute: float = 0.0

var active: bool = false
var time_progress: float = 0.0
var can_construct: bool = false

func _ready():
	time_taken_absolute = (percent_of_day_taken / 100.0) * TimeManager.DAY_LENGTH
	TimeManager.time_changed.connect(on_time_changed)
	TimeManager.day_changed.connect(on_day_changed)
	building.unlock_criteria.unlocked.connect(_on_unlocked)
	cost_label.text = str(building.construction_cost)
	name_label.text = display_name
	update_can_construct()

func on_time_changed(delta: float, new_time: float):
	update_can_construct()
	
	progress_bar.visible = active
	building.on_time_changed(delta, new_time)
	
	if active:
		progress(delta)

func update_can_construct():
	if building.is_fulfilled():
		_set_can_construct()
	else:
		_unset_can_construct()

func _set_can_construct():
	if can_construct:
		return
	button.disabled = false
	cost_label.theme_type_variation = ""
	can_construct = true

func _unset_can_construct():
	if can_construct:
		return
	button.disabled = true
	cost_label.theme_type_variation = "NegativeLabel"
	can_construct = false

func on_day_changed(new_day: int):
	building.on_day_changed(new_day)

func _on_button_pressed():
	if not building.is_fulfilled():
		return
	
	start_work()

func start_work():
	active = true
	time_progress = 0.0
	building.consume_costs()

func progress(delta: float):
	time_progress += delta
	progress_bar.value = (time_progress / time_taken_absolute) * 100.0
	
	if time_progress > time_taken_absolute:
		on_construct()

func on_construct():
	constructed.emit()
	active = false
	building.on_construct()
	name_label.text = display_name + ":"
	amount_label.text = str(building.amount)

func _on_unlocked():
	unlocked.emit()
