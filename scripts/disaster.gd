extends Node2D

export var growth_rate = 0.004
export var extinguish_rate = 0.13

var disaster_scale = 0.07
var size

var stopped = false

onready var nova = $"nova"

func _ready():
    self.size = self.nova.texture.get_size()

func _disaster_tick():
    if not self.stopped:
        self.disaster_scale += self.growth_rate
        self._update_nova_size()
    else:
        self.queue_free()

func _input_event(viewport, event, shape_idx):
    if event is InputEventMouseButton and event.pressed:
        self.disaster_scale -= self.extinguish_rate

        if self.disaster_scale < 0.0:
            self.disaster_scale = 0.01
            self.stopped = true

        self._update_nova_size()

func _update_nova_size():
    self.nova.scale = Vector2(1.0, 1.0) * self.disaster_scale
    #self.nova.texture.set_size(self.size * self.disaster_scale)
