extends Node

class_name GameOver

@export_file("*.tscn") var game_scene: String
@export_file("*.tscn") var main_menu_scene: String
@export var try_again: Button
@export var main_menu: Button

func _ready():
  try_again.pressed.connect(_try_again_pressed)
  main_menu.pressed.connect(_main_menu_pressed)
  
func _try_again_pressed():
  get_tree().paused = false
  Globals.change_scene(game_scene)

func _main_menu_pressed():
  get_tree().paused = false
  Globals.change_scene(main_menu_scene)
  
