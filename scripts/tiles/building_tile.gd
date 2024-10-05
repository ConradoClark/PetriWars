extends Node2D

class_name BuildingTile

var layer: TileMapLayer
var cell_pos: Vector2i

func _ready():
  layer = get_parent()
  cell_pos = layer.local_to_map(position)
  print(cell_pos)
  TileManager.add_tile(cell_pos, self)
