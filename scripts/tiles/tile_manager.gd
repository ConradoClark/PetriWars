extends Node

var tiles: Dictionary = {}

func get_tile(pos: Vector2i):
  if not tiles.has(pos): return null
  return tiles[pos]
  
func add_tile(pos: Vector2i, tile: BuildingTile):
  if tiles.has(pos): 
    push_error("there's a tile in this position already " + str(pos))
  tiles[pos] = tile

func remove_tile(pos: Vector2i):
  if not tiles.has(pos): return
  tiles.erase(pos)
