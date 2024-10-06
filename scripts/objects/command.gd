extends Resource

class_name Command

@export var command_name: String
@export var command_icon: Texture2D
@export_multiline var command_description: String
@export_multiline var validation_msg: String
@export var requirements: Array[CommandRequirement]
@export var command_impl: CommandImpl
@export var arguments: Dictionary

func run():
  command_impl.run(arguments)

func can_run() -> bool:
  for req in requirements:
    if not req.evaluate(): return false
  return true
