extends Node2D

var population_label
var score_label

func _ready():
    self.population_label = $HUD/Bars/Bar/Population/Box/Count
    self.score_label = $HUD/Bars/Bar/Score/Box/Count
    
    self.init_counters()
    
func init_counters():
    self.set_population(7600000000)
    self.set_score(0)
    
func set_population(value):
    self.population_label.set_text(str(value))
    
func set_score(value):
    self.score_label.set_text(str(value))

