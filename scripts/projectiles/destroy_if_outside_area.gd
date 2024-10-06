extends Node

class_name DestroyIfOutsideArea

@export var reference: Node2D

var min_x = -15.
var max_x = 495.
var min_y = -15.
var max_y = 285.

func _process(delta):
  if reference == null: return
  if reference.global_position.x < min_x or\
  reference.global_position.x > max_x or\
  reference.global_position.y < min_y or\
  reference.global_position.y > max_y:
    reference.queue_free()
