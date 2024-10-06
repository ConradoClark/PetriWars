extends Node

class_name EnemyAttackBuilding

@export var damage: int = 1
@export var reference: Node2D
@export var sprite: Node2D
@export var movement: MoveTowardsCoccus
@export var vision_area: Area2D

var attacking: bool = false
var timer: Timer
var target: BuildingTile
var attack_tween: Tween

func _ready():
  timer = Timer.new()
  timer.wait_time = 0.3
  timer.autostart = true
  timer.timeout.connect(_check_radius)
  add_child(timer)

func _check_radius():
  if attacking: return
  var areas = vision_area.get_overlapping_areas()
  if areas.size() > 0:
    attacking = true
    movement.is_moving = false
    target = areas[0].get_parent() as BuildingTile
    call_deferred("_attack")

func _attack():
  if attack_tween: attack_tween.kill()
  while target != null and target.alive:
    attack_tween = create_tween()
    var original_position = reference.global_position
    attack_tween.tween_property(reference, "position", target.global_position, 1.)\
      .set_ease(Tween.EASE_IN)\
      .set_trans(Tween.TRANS_ELASTIC)
    await attack_tween.finished
    if target != null: target.damage(damage)
    attack_tween = create_tween()
    attack_tween.tween_property(reference, "position:x", original_position.x, 2.)\
      .set_ease(Tween.EASE_OUT)\
      .set_trans(Tween.TRANS_QUAD)
    attack_tween.set_parallel(true).tween_property(reference,"position:y", original_position.y, 2.)\
      .set_ease(Tween.EASE_IN_OUT)\
      .set_trans(Tween.TRANS_CUBIC)
    attack_tween.set_parallel(true).tween_property(sprite, "rotation_degrees", 360*2, 2.)\
      .set_ease(Tween.EASE_OUT)\
      .set_trans(Tween.TRANS_QUAD)
    await attack_tween.finished
    sprite.rotation_degrees = 0
  attacking = false
  _check_radius()
  if not attacking: movement.start_moving()
