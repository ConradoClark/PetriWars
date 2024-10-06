extends Node

class_name FindTarget

@export var tile: BuildingTile
@export var area: Area2D
var has_target: bool = false
var target: Enemy
var timer: Timer

func _ready():
  timer = Timer.new()
  timer.autostart = true
  timer.wait_time = 0.3
  timer.timeout.connect(_check)
  add_child(timer)
  
func _check():
  if not tile.built: return
  if has_target: 
    if target == null or not target.alive:
      has_target = false
      target = null
    else: return
  var bodies = area.get_overlapping_bodies()
  for item in bodies:
    var enemy = item as Enemy
    if enemy == null: continue
    if not enemy.alive: continue
    has_target = true
    target = enemy
