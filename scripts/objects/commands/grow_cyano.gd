extends CommandImpl

class_name GrowCyano

func run(args: Dictionary):
  Stats.use_nutrition(3)
  TileManager.map_layer.set_cell(Globals.last_selected_pos,\
    TileTypes.Buildings, Vector2i.ZERO, TileBuildings.Cyano)
  call_deferred("_reselect")

func _reselect():
  Globals.selector.reselect()
