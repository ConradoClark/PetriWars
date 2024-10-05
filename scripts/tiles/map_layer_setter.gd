extends Node

class_name MapLayerSetter

@export var map_layer: TileMapLayer

func _ready():
  TileManager.map_layer = map_layer
