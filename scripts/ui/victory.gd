extends Node

class_name Victory

@export_file("*.tscn") var main_menu_scene: String
@export var main_menu: Button

func _ready():
  main_menu.pressed.connect(_main_menu_pressed)

func _main_menu_pressed():
  get_tree().paused = false
  Globals.change_scene(main_menu_scene)
  
