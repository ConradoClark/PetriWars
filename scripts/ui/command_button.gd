extends Control

class_name CommandButton

@export var command: Command
@onready var texture_rect = $TextureRect

var clickable: bool = false
var hovering: bool = false

func _ready():
  texture_rect.texture = command.command_icon
  texture_rect.gui_input.connect(_on_gui_input)
  texture_rect.mouse_entered.connect(_on_mouse_entered)
  texture_rect.mouse_exited.connect(_on_mouse_exited)
  Globals.on_dna_increased.connect(_on_stat_change)
  Globals.on_dna_decreased.connect(_on_stat_change)
  Globals.on_nutrition_increased.connect(_on_stat_change)
  Globals.on_nutrition_decreased.connect(_on_stat_change)
  UIEvents.selected_object_changed.connect(_on_selection_changed)
  check_clickable()
  
func _on_stat_change(amount: int):
  check_clickable()
  
func _on_selection_changed(unit: Unit):
  check_clickable()

func check_clickable():
  var result = command.can_run()
  if result != clickable:
   if hovering: _on_mouse_entered()
   clickable = result

func _on_mouse_entered():
  hovering = true
  UIEvents.command_mouse_entered.emit(command)
  
func _on_mouse_exited():
  hovering = false
  UIEvents.command_mouse_exited.emit(command)
  
func _on_gui_input(event):
  if event is InputEventMouseButton:
    if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
      if clickable:
        command.run()
      else:
        print("command doesn't meet requirements")
