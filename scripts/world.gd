extends Node2D

onready var disasters = $"disasters"
onready var disaster_timer = $"timer"
onready var hud = $"../HUD"
onready var snafu = $".."

export var disaster_limit = 6

var templates = []

var extinguish_count = 0
var disaster_count = 0
var population = 7600000000
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
    self.templates = [
        preload("res://scenes/reusable/disasters/deadly_meteor.tscn"),
        preload("res://scenes/reusable/disasters/deadly_fire.tscn"),
        preload("res://scenes/reusable/disasters/deadly_flood.tscn"),
        preload("res://scenes/reusable/disasters/meteor.tscn"),
        preload("res://scenes/reusable/disasters/fire.tscn"),
        preload("res://scenes/reusable/disasters/heat.tscn"),
        preload("res://scenes/reusable/disasters/volcano.tscn"),
        preload("res://scenes/reusable/disasters/totalitarism.tscn"),
        preload("res://scenes/reusable/disasters/tornado.tscn"),
        preload("res://scenes/reusable/disasters/storm.tscn"),
        preload("res://scenes/reusable/disasters/flood.tscn"),
       ]

func _disaster_happens():
    self._spawn_new_disaster()
    if self.disaster_timer.wait_time < 2.0:
        self._spawn_new_disaster()
    if self.disaster_timer.wait_time < 1.6:
        self._spawn_new_disaster()

func _spawn_new_disaster():
    if self.disaster_count >= self.disaster_limit:
        return

    var templates_size = self.templates.size()
    var random_disaster = randi() % templates_size
    var new_disaster = self.templates[random_disaster].instance()

    self.disasters.add_child(new_disaster)
    new_disaster.position = self._get_random_position()
    self.disaster_count += 1

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

func extinguished():
    var extinguish_haste = 10
    self.extinguish_count += 1
    self.disaster_count -= 1

    if self.extinguish_count > extinguish_haste:
        self.extinguish_count -= extinguish_haste
        if self.disaster_timer.wait_time > 1.5:
            self.disaster_timer.wait_time -= 0.1

func add_score(value):
    self.score = self.score + value
    self.hud.set_score(self.score)

func kill_people(value):
    self.population = self.population - value
    if self.population <= 0:
        self.population = 0
        self.end_game()
    self.hud.set_population(self.population)

func end_game():
    self.snafu.end_game()

