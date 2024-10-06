extends Sprite2D

class_name NutritionResourceUp

var tween: Tween
var pos_offset: Vector2 = Vector2(0, -12.)

func _ready():
  call_deferred("_run")
  
func _run():
  tween = create_tween()
  tween.tween_property(self, "global_position", global_position + pos_offset, 1.)
  tween.set_parallel().tween_property(self, "modulate", Color.TRANSPARENT, 1.5)
  await tween.finished
  queue_free()
  
