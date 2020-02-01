extends Node2D

export var growth_rate = 0.01
export var extinguish_rate = 0.13
export var lethality = 525000
export var max_scale = 2.0

var disaster_scale = 0.07
var size

var stopped = false

onready var nova = $"nova"
onready var world = $"../../../world"
onready var click_player = $"click"

func _ready():
	self.size = self.nova.texture.get_size()

func _disaster_tick():
	if not self.stopped:
		self.disaster_scale += self.growth_rate

		if self.disaster_scale > self.max_scale:
			self.disaster_scale = self.max_scale

		self._update_nova_size()
		self.world.kill_people(int(self.disaster_scale * self.disaster_scale * self.lethality))
	else:
		self.queue_free()

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		self.click_player.play()
		self.disaster_scale -= self.extinguish_rate

		if self.disaster_scale < 0.0 and not self.stopped:
			self.disaster_scale = 0.01
			self.stopped = true

			self.world.extinguished()
			self.world.add_score(100)
		else:
			self.world.add_score(15)

		self._update_nova_size()

func _update_nova_size():
	self.nova.rect_scale = Vector2(1.0, 1.0) * self.disaster_scale
