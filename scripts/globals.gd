extends Node

var selector: Selector
var last_selected_pos: Vector2i
var command_container: CommandContainer
var resource_harvest_rate = 5.
var current_wave: int = 0
var main_structures: Array[BuildingTile]
var ui_canvas: CanvasLayer

const GAME_OVER = preload("res://scenes/screens/coccus_destroyed.tscn")

signal on_nutrition_increased(new_value: int)
signal on_dna_increased(new_value:int)
signal on_nutrition_decreased(new_value: int)
signal on_dna_decreased(new_value:int)

signal on_wave_start

func show_game_over():
  var overlay = GAME_OVER.instantiate()
  ui_canvas.add_child(overlay)

func change_scene(scene: String):
  var instance = load(scene).instantiate()
  get_tree().root.add_child(instance)
  await get_tree().process_frame
  var old_scene = get_tree().current_scene
  get_tree().current_scene = instance
  old_scene.free()
