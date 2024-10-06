extends Node2D

class_name EnemySpawner

@export var waves: Array[EnemyWave]
@export var wave_times_seconds: Array[int]
var current_wave: EnemyWave

var timer: Timer
var tick_timer: Timer
var spawn_timer: Timer
var spawns: Dictionary

var spawn_rng_radius = 35.

@export var east_reference: Node2D
@export var west_reference: Node2D
@export var north_reference: Node2D
@export var south_reference: Node2D
@export var northeast_reference: Node2D
@export var northwest_reference: Node2D
@export var southeast_reference: Node2D
@export var southwest_reference: Node2D

@export var east_arrow: AnimatedSprite2D
@export var west_arrow: AnimatedSprite2D
@export var north_arrow: AnimatedSprite2D
@export var south_arrow: AnimatedSprite2D
@export var northwest_arrow: AnimatedSprite2D
@export var northeast_arrow: AnimatedSprite2D
@export var southwest_arrow: AnimatedSprite2D
@export var southeast_arrow: AnimatedSprite2D

func _ready():
  _show_next_wave_arrows(0)
  timer = Timer.new()
  timer.wait_time = wave_times_seconds[Globals.current_wave]
  timer.autostart = true
  tick_timer = Timer.new()
  tick_timer.wait_time = 0.1
  tick_timer.autostart = true
  timer.timeout.connect(_timer_timeout)
  tick_timer.timeout.connect(_tick_timeout)
  spawn_timer = Timer.new()
  spawn_timer.timeout.connect(_spawn_unit)
  add_child(spawn_timer)
  add_child(timer)
  add_child(tick_timer)
  
func _tick_timeout():
  UIEvents.tick_timer.emit(timer.time_left)

func _timer_timeout():
  tick_timer.stop()
  timer.stop()
  spawn_wave()
  Globals.current_wave+=1
  Globals.on_wave_start.emit()
  
func _show_next_wave_arrows(wave_number: int):
  east_arrow.visible = false
  west_arrow.visible = false
  north_arrow.visible = false
  south_arrow.visible = false
  northwest_arrow.visible = false
  northeast_arrow.visible = false
  southwest_arrow.visible = false
  southeast_arrow.visible = false
  if wave_number > waves.size(): return
  var wave = waves[wave_number]
  for dir in wave.directions:
    match dir:
      EnemyWave.Direction.WEST: west_arrow.visible = true
      EnemyWave.Direction.EAST: east_arrow.visible = true
      EnemyWave.Direction.NORTH: north_arrow.visible = true
      EnemyWave.Direction.SOUTH: south_arrow.visible = true
      EnemyWave.Direction.NORTHWEST: northwest_arrow.visible = true
      EnemyWave.Direction.NORTHEAST: northeast_arrow.visible = true
      EnemyWave.Direction.SOUTHWEST: southwest_arrow.visible = true
      EnemyWave.Direction.SOUTHEAST: southeast_arrow.visible = true

func spawn_wave():
  var wave = waves[Globals.current_wave]
  current_wave = wave.duplicate()
  var total_amount = 0
  for spawn in wave.spawns:
    total_amount += spawn.amount
  var spawn_frequency = wave.duration_seconds / total_amount
  spawn_timer.wait_time = spawn_frequency
  spawn_timer.start()
  await get_tree().create_timer(wave.duration_seconds + wave.wait_time_seconds).timeout
  spawn_timer.stop()
  if wave_times_seconds.size() > Globals.current_wave:
    _show_next_wave_arrows(Globals.current_wave)
    timer.wait_time = wave_times_seconds[Globals.current_wave]
    timer.start()
    tick_timer.start()
  else:
    while get_tree().get_node_count_in_group("enemy") > 0:
      await get_tree().process_frame
    get_tree().paused = true
    Globals.show_victory()
  
func _spawn_unit():
  var max = current_wave.spawns.size() - 1 
  var rng = randi_range(0, max)
  var direction_rng = randi_range(0, current_wave.directions.size() - 1)
  var direction = current_wave.directions[direction_rng]
  if current_wave.spawns[rng].amount > 0:
    current_wave.spawns[rng].amount-=1
    var path = current_wave.spawns[rng].prefab_path
    _spawn_at_direction(path, direction)
    return
  for spawn in current_wave.spawns:
    if spawn.amount <=0: continue
    spawn.amount-=1
    _spawn_at_direction(spawn.prefab_path, direction)
    return
    
func _random_inside_unit_circle() -> Vector2:
    var theta : float = randf() * 2 * PI
    return Vector2(cos(theta), sin(theta)) * sqrt(randf())
    
func _spawn_at_direction(path: String, direction: EnemyWave.Direction):
  if not spawns.has(path):
    spawns[path] = load(path) as PackedScene
  var spawn = spawns[path].instantiate() as Enemy
  var rng = _random_inside_unit_circle() * spawn_rng_radius
  match direction:
    EnemyWave.Direction.NORTH:
      spawn.global_position = north_reference.global_position + rng
    EnemyWave.Direction.SOUTH:
      spawn.global_position = south_reference.global_position + rng
    EnemyWave.Direction.EAST:
      spawn.global_position = east_reference.global_position + rng
    EnemyWave.Direction.WEST:
      spawn.global_position = west_reference.global_position + rng
    EnemyWave.Direction.NORTHEAST:
      spawn.global_position = northeast_reference.global_position + rng
    EnemyWave.Direction.NORTHWEST:
      spawn.global_position = northwest_reference.global_position + rng
    EnemyWave.Direction.SOUTHEAST:
      spawn.global_position = southeast_reference.global_position + rng
    EnemyWave.Direction.SOUTHWEST:
      spawn.global_position = southwest_reference.global_position + rng
  add_child(spawn)
