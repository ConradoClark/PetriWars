extends Node

var selector: Selector
var last_selected_pos: Vector2i
var command_container: CommandContainer
var resource_harvest_rate = 5.

signal on_nutrition_increased(new_value: int)
signal on_dna_increased(new_value:int)
signal on_nutrition_decreased(new_value: int)
signal on_dna_decreased(new_value:int)
