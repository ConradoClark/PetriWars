extends Node

class_name BacillusBuff

@export var value: int

func _ready():
  Globals.on_max_life_up.emit(value)
  
func _exit_tree():
  Globals.on_max_life_down.emit(value)
