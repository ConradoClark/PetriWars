extends Node

class_name InitializeBase

func _ready():
  TileManager.reset_tiles()
  Stats.reset_stats()
  Globals.current_wave = 0
