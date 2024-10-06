extends Node

class_name MoveTowardsCoccus

@export var reference: CharacterBody2D
@export var speed: float
@export var move_time_seconds: float
@export var pause_time_seconds: float

var is_moving: bool = false
var move_tween: Tween

func _ready():
  is_moving = true
  call_deferred("_move")
  
func _move():
  while is_moving:
    var target = _find_coccus()
    if target == null:
      await get_tree().create_timer(pause_time_seconds).timeout
      continue
    if move_tween: move_tween.kill()
    move_tween = create_tween()
    var direction = (target.global_position - reference.global_position + _random_inside_unit_circle()*16).normalized()
    move_tween.tween_property(reference, "position", reference.global_position + (direction * speed), move_time_seconds)
    while move_tween.is_running():
      if not is_moving:
        move_tween.kill()
        return
      await get_tree().process_frame
    await get_tree().create_timer(pause_time_seconds + randf_range(-0.5, 0.5), false).timeout

func start_moving():
  is_moving = true
  _move()

func _find_coccus() -> Node2D:
  var selected = null
  for structure in Globals.main_structures:
    if selected == null:
      selected = structure
      continue
    var current_dist = (reference.global_position - selected.global_position).length()
    var dist = (reference.global_position - structure.global_position).length()
    if dist < current_dist:
      selected = structure
  if selected == null: return null
  return selected
  
func _random_inside_unit_circle() -> Vector2:
    var theta : float = randf() * 2 * PI
    return Vector2(cos(theta), sin(theta)) * sqrt(randf())
