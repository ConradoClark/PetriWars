extends Node

class_name GenerateNutrition

@export var reference: BuildingTile
@export var amount: int
var timer: Timer
const RESOURCE_GAUGE = preload("res://scenes/ui/resource_gauge.tscn") as PackedScene
var gauge: Gauge
var offset = Vector2(0, -19)

func _ready():
  reference.on_built.connect(_on_built)
  reference.selected_changed.connect(_on_selected_changed)

func _on_built():
  timer = Timer.new()
  timer.wait_time = 5.
  timer.autostart = true
  timer.timeout.connect(_on_timeout)
  gauge = RESOURCE_GAUGE.instantiate() as Gauge
  gauge.global_position = reference.global_position + offset
  gauge.seconds = Globals.resource_harvest_rate
  gauge.visible = reference.selected
  add_child(gauge)
  add_child(timer)
  
func _on_selected_changed():
  if gauge: gauge.visible = reference.selected

func _on_timeout():
  Stats.add_nutrition(amount)
  gauge = RESOURCE_GAUGE.instantiate() as Gauge
  gauge.global_position = reference.global_position + offset
  gauge.seconds = Globals.resource_harvest_rate
  gauge.visible = reference.selected
  add_child(gauge)
