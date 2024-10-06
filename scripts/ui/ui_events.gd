extends Node

signal selected_object_changed(unit: Unit)
signal command_mouse_entered(command: Command)
signal command_mouse_exited(command: Command)
signal ui_text_changed(text: String, type: UITextType)
signal tick_timer(time_left: int)

enum UITextType { 
  ObjectName, 
  ObjectDescription, 
  CommandName, 
  CommandDescription, 
  NutritionCounter,
  DNACounter,
  CommandValidation,
  NextWave
}

func _ready():
  selected_object_changed.connect(_on_selected_object_changed)
  command_mouse_entered.connect(_command_mouse_entered)
  command_mouse_exited.connect(_command_mouse_exited)
  tick_timer.connect(_on_tick_timer)
  Globals.on_nutrition_increased.connect(_on_nutrition_changed)
  Globals.on_dna_increased.connect(_on_dna_changed)
  Globals.on_nutrition_decreased.connect(_on_nutrition_changed)
  Globals.on_dna_decreased.connect(_on_dna_changed)
  Globals.on_wave_start.connect(_on_wave_start)
  
func _on_tick_timer(time_left: int):
  ui_text_changed.emit('[right][color=ffa7b9]WAVE %s[/color] IN [color=ffa7b9]%s[/color] SECONDS' % [str(Globals.current_wave+1), time_left], UITextType.NextWave)

func _on_wave_start():
  ui_text_changed.emit('[right][color=ffa7b9]WAVE %s[/color] IN PROGRESS' % str(Globals.current_wave), UITextType.NextWave)

func _command_mouse_entered(command:Command):
  ui_text_changed.emit(command.command_name, UITextType.CommandName)
  ui_text_changed.emit(command.command_description, UITextType.CommandDescription)
  if command.can_run(): 
    ui_text_changed.emit('', UITextType.CommandValidation)
  else:
    ui_text_changed.emit(command.validation_msg, UITextType.CommandValidation)
    
func _command_mouse_exited(command: Command):
  ui_text_changed.emit('COMMANDS', UITextType.CommandName)
  ui_text_changed.emit('', UITextType.CommandDescription)
  ui_text_changed.emit('', UITextType.CommandValidation)

func _on_nutrition_changed(new_value: int):
  ui_text_changed.emit(str(new_value).lpad(2, "0"), UITextType.NutritionCounter)
  
func _on_dna_changed(new_value: int):
  ui_text_changed.emit(str(new_value).lpad(2, "0"), UITextType.DNACounter)

func _on_selected_object_changed(unit: Unit):
  ui_text_changed.emit(unit.unit_name, UITextType.ObjectName)
  ui_text_changed.emit(unit.unit_description, UITextType.ObjectDescription)
  ui_text_changed.emit("" if unit.commands.size() == 0 else "COMMANDS", UITextType.CommandName)
  ui_text_changed.emit("", UITextType.CommandDescription)
  ui_text_changed.emit('', UITextType.CommandValidation)
