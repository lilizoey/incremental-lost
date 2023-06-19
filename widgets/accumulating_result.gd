class_name AccumulatingResult extends Result

@export var progress_min: float = 1.0
@export var progress_max: float = 1.0
@export var target_progress: float = 1.0
@export var final_result: Result

var progress: float = 0.0

func perform():
	var to_progress = randf_range(progress_min, progress_max)
	progress += to_progress
	if progress >= target_progress:
		progress -= target_progress
		final_result.perform()
