extends Control

class_name Gauge

var seconds: float
var starting_value: float
var timer: SceneTreeTimer
@export var reference: Node
@export var gauge: TextureRect
@export var min_size: float = 0.
@export var max_size: float = 16.
@export var ticks: bool = false

func _ready():
  call_deferred("_adjust_size")
  if ticks:
    timer = get_tree().create_timer(seconds, false)
    call_deferred("_tick")
    
func _adjust_size():
  gauge.size.x = lerp(min_size, max_size, starting_value)

func _tick():
  while timer.time_left > 0.:
    gauge.size.x = lerp(min_size, max_size, (seconds - timer.time_left) / seconds)
    await get_tree().process_frame
  reference.queue_free()
