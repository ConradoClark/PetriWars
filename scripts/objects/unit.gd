extends Resource

class_name Unit

@export var unit_name: String
@export var unit_description: String
@export var life: int
@export var max_life: int
@export var type: Type
@export var commands: Array[Command]

enum Type { Player, Map, Enemy }

func _ready():
  life = max_life
