extends Node2D

onready var disasters = $"disasters"

var templates = []

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    self.templates = [
        preload("res://scenes/reusable/disasters/meteor.tscn"),
        preload("res://scenes/reusable/disasters/fire.tscn"),
        preload("res://scenes/reusable/disasters/heat.tscn"),
        preload("res://scenes/reusable/disasters/volcano.tscn"),
        preload("res://scenes/reusable/disasters/totalitarism.tscn"),
        preload("res://scenes/reusable/disasters/tornado.tscn"),
        preload("res://scenes/reusable/disasters/storm.tscn"),
       ]

func _disaster_happens():
    var templates_size = self.templates.size()
    var random_disaster = randi() % templates_size
    var new_disaster = self.templates[random_disaster].instance()
    
    self.disasters.add_child(new_disaster)
    new_disaster.position = self._get_random_position()

func _get_random_position():
    var screen_size_x = 1920
    var screen_size_y = 1080
    var screen_margin_x = 100
    var screen_margin_y = 100
    var x = self._get_random_dimension(screen_size_x, screen_margin_x)
    var y = self._get_random_dimension(screen_size_y, screen_margin_y)
    
    return Vector2(x,y)

func _get_random_dimension(size, margin):
    var available_size = size - 2*margin
    return (randi() % available_size) + margin
    
