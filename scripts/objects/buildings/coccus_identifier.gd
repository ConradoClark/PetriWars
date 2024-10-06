extends Node

class_name CoccusIdentifier

@export var coccus: BuildingTile

func _ready():
  Globals.main_structures.append(coccus)
