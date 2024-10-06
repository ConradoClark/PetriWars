extends Node2D

class_name Projectile

var direction: Vector2
@export var speed: float
@export var area: Area2D
@export var damage: int = 1

var timer: Timer

func _ready():
  timer = Timer.new()
  timer.autostart = true
  timer.wait_time = 0.1
  timer.timeout.connect(_check_collisions)
  add_child(timer)

func destroy():
  queue_free()

func _check_collisions():
  var areas = area.get_overlapping_bodies()
  for enemy in areas:
    if not enemy is Enemy: continue
    enemy.damage(damage)
    destroy()
    return
