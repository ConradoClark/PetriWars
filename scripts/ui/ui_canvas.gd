extends Node

class_name UICanvas

@export var canvas: CanvasLayer

func _ready():
  Globals.ui_canvas = canvas
