extends CharacterBody2D

class_name Enemy

@export var max_life: int
var life: int
var alive: bool = true

signal on_damage(damage: int)
signal on_death

func _ready():
  life = max_life
  add_to_group("enemy")
  
func _exit_tree():
  remove_from_group("enemy")

func damage(amount: int ):
  if not alive: return
  life = clamp(life - 1, 0 , max_life)
  on_damage.emit(amount)
  if life == 0:
    on_death.emit()
    queue_free()
