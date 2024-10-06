extends Node2D

class_name EnemySpawner

@export var waves: Array[EnemyWave]
@export var wave_times_seconds: Array[int]

var timer: Timer
var tick_timer: Timer

func _ready():
  timer = Timer.new()
  timer.wait_time = wave_times_seconds[Globals.current_wave]
  timer.autostart = true
  tick_timer = Timer.new()
  tick_timer.wait_time = 0.1
  tick_timer.autostart = true
  timer.timeout.connect(_timer_timeout)
  tick_timer.timeout.connect(_tick_timeout)
  add_child(timer)
  add_child(tick_timer)

func _tick_timeout():
  UIEvents.tick_timer.emit(timer.time_left)

func _timer_timeout():
  tick_timer.stop()
  timer.stop()
  Globals.current_wave+=1
  Globals.on_wave_start.emit()
  spawn_wave()
  
func spawn_wave():
  pass
