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
  
func is_adjacent_to_tiles(pos: Vector2i, amount: int, tag: String) -> bool:
  var count = 0
  for cell in map_layer.get_surrounding_cells(pos):
    var tile = get_tile(cell)
    if not tile: continue
    if tile.unit.has_tag(tag): count+=1
  return count >= amount
