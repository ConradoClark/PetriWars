extends Label

class_name UpdateableLabel

@export var type: UIEvents.UITextType
@export var prefix: String
@export var starting_value: String

func _ready():
  text = starting_value
  UIEvents.ui_text_changed.connect(_ui_text_changed)
  
func _ui_text_changed(value: String, text_type: UIEvents.UITextType):
  if type != text_type: return
  text = prefix + value
