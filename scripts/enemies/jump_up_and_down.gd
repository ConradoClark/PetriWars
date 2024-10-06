extends Node

class_name JumpUpAndDown

@export var reference: Node2D
@export var jump_at_start: bool = true
@export var jump_height: float
@export var jump_frequency_seconds: float

var jumping = false
var jump_tween: Tween

func _ready():
  if jump_at_start: call_deferred("start_jumping")
  
func start_jumping():
  if jumping: return
  jumping = true
  _jump()
  
func stop_jumping():
  if jumping:
    jumping = false
    
func _jump():
  while jumping:
    if jump_tween: jump_tween.kill()
    jump_tween = create_tween()
    jump_tween.tween_property(reference, "position:y", -jump_height,\
      jump_frequency_seconds*0.5)\
    .set_ease(Tween.EASE_OUT)\
    .set_trans(Tween.TRANS_QUAD)
    jump_tween.tween_property(reference, "position:y", 0,\
      jump_frequency_seconds*0.5)\
    .set_ease(Tween.EASE_OUT)\
    .set_trans(Tween.TRANS_BOUNCE)
    await jump_tween.finished
      
      
    
