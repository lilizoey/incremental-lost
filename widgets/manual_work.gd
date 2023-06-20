@tool extends PanelContainer

@export var display_name: String = "":
	set(new_name):
		display_name = new_name
		$Label.text = new_name
@export var requirements: Array[Requirement] = []
@export var results: Array[Result] = []
@export var percent_of_day_taken: float = 100.0
@export var exclusive: bool = false
@export var cancelable: bool = true

@onready var progress_bar: ProgressBar = $ProgressBar

signal finished

var time_taken_absolute: float = 0.0

var active: bool = false
var time_progress: float = 0.0

func _ready():
	if Engine.is_editor_hint():
		return
	time_taken_absolute = (percent_of_day_taken / 100.0) * TimeManager.DAY_LENGTH
	TimeManager.time_changed.connect(progress)

func progress(delta, new_time):
	if Engine.is_editor_hint():
		return
	progress_bar.visible = active
	
	if not active:
		return
	
	time_progress += delta
	progress_bar.value = (time_progress / time_taken_absolute) * 100.0
	
	if time_progress > time_taken_absolute:
		finish()

func finish():
	finished.emit()
	active = false
	for result in results:
		result.perform()
	
	if exclusive:
		WorkManager.performing_exclusive_work = false

func _on_button_pressed():
	for requirement in requirements:
		if not requirement.is_fulfilled():
			return
	
	if WorkManager.performing_exclusive_work:
		return
	
	start_work()

func start_work():
	if exclusive:
		WorkManager.performing_exclusive_work = true
	
	active = true
	time_progress = 0.0
	
	for requirement in requirements:
		requirement.perform_consume() 
