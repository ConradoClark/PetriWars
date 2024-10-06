extends Node2D

class_name Selector

@export var clickable_area: Area2D
var shape_owner: CollisionShape2D
var shape: RectangleShape2D
var shape_rect: Rect2
@onready var green = $Green
@onready var yellow = $Yellow
const EMPTY_TILE = preload("res://data/units/empty_tile.tres")

func _ready():
  Globals.selector = self
  green.visible = false
  yellow.visible = false
  shape_owner = clickable_area.shape_owner_get_owner(0) as CollisionShape2D
  shape = clickable_area.shape_owner_get_shape(0,0)
  shape_rect = shape.get_rect()
  pass
  
func reselect():
  _select(TileManager.map_layer.to_global(\
    TileManager.map_layer.map_to_local(Globals.last_selected_pos)))
  
func _select(pos: Vector2):
    var rect = Rect2(shape_rect.position + shape_owner.global_position, shape_rect.size)
    if rect.has_point(pos):
      var local = TileManager.map_layer.to_local(pos)
      var map_pos = TileManager.map_layer.local_to_map(local)
      Globals.last_selected_pos = map_pos
      var tile = TileManager.get_tile(map_pos)
      green.visible = tile != null
      yellow.visible = not green.visible
      global_position = TileManager.map_layer.map_to_local(map_pos)
      if tile && tile.unit:
        UIEvents.selected_object_changed.emit(tile.unit)
      else:
        UIEvents.selected_object_changed.emit(EMPTY_TILE)

func _input(event):
  if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
    if not event.is_pressed(): return
    var mouse_pos = get_global_mouse_position()
    _select(mouse_pos)
