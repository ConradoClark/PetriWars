extends Resource

class_name Unit

@export var unit_name: String
@export var unit_description: String
@export var life: int
@export var max_life: int
@export var type: Type
@export var commands: Array[Command]
@export var tags: Array[String]
@export var build_time_seconds: float = 2.

enum Type { Player, Map, Enemy }

func _ready():
  life = max_life

func has_tag(tag: String):
  return tags.has(tag)
