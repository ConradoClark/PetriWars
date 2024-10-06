extends Node

class_name FadeEffect

var reference: Node2D
var tween: Tween

func _ready():
  reference = get_parent() as Node2D
  call_deferred("_fade")
  
func _fade():
  while self != null:
    if tween:
      tween.kill()
    tween = create_tween()
    tween.tween_property(reference, "modulate", Color.TRANSPARENT, 2.)\
      .set_ease(Tween.EASE_IN)\
      .set_trans(Tween.TRANS_QUAD)
    tween.tween_property(reference, "modulate", Color.WHITE, 2.)\
      .set_ease(Tween.EASE_OUT)\
      .set_trans(Tween.TRANS_QUAD)
    await tween.finished
