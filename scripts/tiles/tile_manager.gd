extends Node

var tiles: Dictionary = {}
var map_layer: TileMapLayer

func set_layer(layer: TileMapLayer):
  layer = map_layer
  
func has_tile(pos: Vector2i):
  return tiles.has(pos)

func get_tile(pos: Vector2i) -> BuildingTile:
  if not tiles.has(pos): return null
  return tiles[pos]
  
func add_tile(pos: Vector2i, tile: BuildingTile):
  if tiles.has(pos): 
    push_error("there's a tile in this position already " + str(pos))
  tiles[pos] = tile

func remove_tile(pos: Vector2i):
  if not tiles.has(pos): return
  tiles.erase(pos)
