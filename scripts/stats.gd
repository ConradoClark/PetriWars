extends Node

var nutrition: int = 3
var dna: int
var enemies_killed: int

func _init():
  call_deferred("add_nutrition", 0)
  
func reset_stats():
  nutrition = 3
  dna = 0
  enemies_killed = 0 

func add_nutrition(amount: int):
  nutrition += amount
  Globals.on_nutrition_increased.emit(nutrition)
  
func add_dna(amount: int):
  dna += amount
  Globals.on_dna_increased.emit(dna)
  
func use_nutrition(amount: int):
  nutrition -= amount
  Globals.on_nutrition_decreased.emit(nutrition)
  
func use_dna(amount: int):
  dna -= amount
  Globals.on_nutrition_decreased.emit(dna)
