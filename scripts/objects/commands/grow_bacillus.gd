extends CommandImpl

class_name GrowBacillus

func run(args: Dictionary):
  Stats.use_nutrition(2)
  TileManager.map_layer.set_cell(Globals.last_selected_pos,\
    TileTypes.Buildings, Vector2i.ZERO, TileBuildings.Bacillus)
  call_deferred("_reselect")

func _reselect():
  Globals.selector.reselect()
