extends Area2D

func _input(event):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		get_tree().change_scene("scenes/snafu.tscn")
