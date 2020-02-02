extends Area2D

var is_loading = false

onready var loading = $"loading"
onready var timer = $"Timer"

func _ready():
    $"score".set_text(str(global_score.get_score()))

func _input(event):
    if Input.is_key_pressed(KEY_ESCAPE):
        get_tree().quit()

func _input_event(viewport, event, shape_idx):
    if self.is_loading:
        return

    if event is InputEventMouseButton and event.pressed:
        self.loading.show()
        self.is_loading = true
        self.timer.start()

func _load_snafu():
    get_tree().change_scene("scenes/snafu.tscn")
