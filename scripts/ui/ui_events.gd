extends Node

signal selected_object_changed(unit: Unit)

signal ui_text_changed(text: String, type: UITextType)

enum UITextType { ObjectName, ObjectDescription, CommandName, CommandDescription }

func _ready():
  selected_object_changed.connect(_on_selected_object_changed)
  
func _on_selected_object_changed(unit: Unit):
  ui_text_changed.emit(unit.unit_name, UITextType.ObjectName)
  ui_text_changed.emit(unit.unit_description, UITextType.ObjectDescription)
  ui_text_changed.emit("", UITextType.CommandName)
  ui_text_changed.emit("", UITextType.CommandDescription)
