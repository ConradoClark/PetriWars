extends CommandImpl

class_name GrowPseudo

func run(args: Dictionary):
  Stats.use_nutrition(10)
  TileManager.map_layer.set_cell(Globals.last_selected_pos,\
    TileTypes.Buildings, Vector2i.ZERO, TileBuildings.Pseudo)
  call_deferred("_reselect")

func _reselect():
  Globals.selector.reselect()
