extends Node

class_name CoccusDestroyed

@export var coccus: BuildingTile

func _ready():
  coccus.on_death.connect(_on_death)
  
func _on_death():
  get_tree().paused = true
  Globals.show_game_over()
