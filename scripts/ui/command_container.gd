extends HBoxContainer

class_name CommandContainer

var children: Array[CommandButton] = []
const COMMAND_BUTTON = preload("res://scenes/ui/command_button.tscn") as PackedScene

func _ready():
  Globals.command_container = self
  UIEvents.selected_object_changed.connect(_selected_object_changed)

func _selected_object_changed(unit: Unit):
  set_commands(unit.commands)

func set_commands(commands: Array[Command]):
  for child in children:
    child.queue_free()
  children.clear()
  for command in commands:
    var button = COMMAND_BUTTON.instantiate() as CommandButton
    button.command = command
    add_child(button)
    children.append(button)
