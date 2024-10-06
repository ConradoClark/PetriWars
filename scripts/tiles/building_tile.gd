extends Node2D

class_name BuildingTile

@export var unit: Unit
@onready var sprite = $Sprite
@onready var building_sprite = $BuildingSprite

var layer: TileMapLayer
var cell_pos: Vector2i
var selected: bool
var life: int
var built: bool = false
var alive:bool = true

const LIFE_GAUGE = preload("res://scenes/ui/life_gauge.tscn") as PackedScene
const BUILD_GAUGE = preload("res://scenes/ui/build_gauge.tscn") as PackedScene
var build_gauge: Gauge
var build_gauge_offset = Vector2(0,-4)

var life_gauge: Gauge
var life_gauge_offset = Vector2(0,-14)

signal selected_changed
signal on_built
signal on_damage(amount: int)
signal on_death

func _ready():
  layer = get_parent()
  cell_pos = layer.local_to_map(position)
  life = unit.max_life
  TileManager.add_tile(cell_pos, self)
  UIEvents.selected_object_changed.connect(_selected_object_changed)
  call_deferred("_initialize_life_gauge")
  call_deferred("_build")
  
func _build():
  if unit.build_time_seconds == 0: 
    if building_sprite: building_sprite.visible = false
    sprite.visible = true
    _on_build_finished()
    return
  if building_sprite: building_sprite.visible = true
  sprite.visible = false
  build_gauge = BUILD_GAUGE.instantiate()
  build_gauge.seconds = unit.build_time_seconds
  add_child(build_gauge)
  call_deferred("_setup_build_gauge")
  
func _on_build_finished():
  if building_sprite: building_sprite.visible = false
  sprite.visible = true
  built = true
  on_built.emit()

func _initialize_life_gauge():
  life_gauge = LIFE_GAUGE.instantiate() as Gauge
  life_gauge.starting_value = 1.
  life_gauge.visible = selected or life < unit.max_life
  add_child(life_gauge)
  call_deferred("_reposition_life_gauge")
  
func _reposition_life_gauge():
  life_gauge.global_position = global_position + life_gauge_offset
  
func _setup_build_gauge():
  build_gauge.global_position = global_position + build_gauge_offset
  build_gauge.timer.timeout.connect(_on_build_finished, CONNECT_ONE_SHOT)

func _selected_object_changed(unit: Unit):
  selected = Globals.last_selected_pos == cell_pos
  if life_gauge: life_gauge.visible = selected or life < unit.max_life
  selected_changed.emit()
  
func damage(amount: int):
  life = clamp(life-amount, 0, unit.max_life)
  life_gauge.set_value(life / float(unit.max_life))
  on_damage.emit(amount)
  life_gauge.visible = selected or life < unit.max_life
  if life == 0:
    alive = false
    on_death.emit()
    TileManager.remove_tile(cell_pos)
