extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func _input(event):
    if Input.is_key_pressed(KEY_ESCAPE):
        quit_game()

func quit_game():
    get_tree().quit()
