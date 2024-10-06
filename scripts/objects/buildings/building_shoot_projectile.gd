extends Node

class_name BuildingShootProjectile

@export var reference: Node2D
@export var target_finder: FindTarget
@export var cooldown_ms: float
@export_file("*.tscn") var projectile_path: String
var prefab: PackedScene
var timer: Timer

func _ready():
  prefab = load(projectile_path) as PackedScene
  timer = Timer.new()
  timer.autostart = true
  timer.wait_time = cooldown_ms * 0.001
  timer.timeout.connect(_shoot)
  add_child(timer)
  
func _shoot():
  if not target_finder.has_target: return
  var projectile = prefab.instantiate() as Projectile
  projectile.global_position = reference.global_position
  projectile.direction = (target_finder.target.global_position - reference.global_position).normalized()
  Globals.projectile_container.add_child(projectile)
