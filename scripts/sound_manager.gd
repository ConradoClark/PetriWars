extends Node

var sound_players: Array[AudioStreamPlayer] = []
var sounds_dict = {}

var free: Array[AudioStreamPlayer] = []
var music: AudioStreamPlayer = AudioStreamPlayer.new()
var current_music: AudioStream

var sample_loops = {}

var target_db_music: float = -12.

func set_music(song: AudioStream):
  if current_music == song: return
  await get_tree().create_timer(0.5).timeout
  current_music = song
  if not music.playing or music.stream != song:
    music.volume_db = -40.
    _fade_music_in()
    music.stream = song
    music.play()
    
func _fade_music_in():
  var tween = get_tree().create_tween()
  tween.tween_property(music, "volume_db", target_db_music, 1)
    
func stop_music():
  if not music.playing or not music.stream: return
  music.stop()

func start_sample_loop(stream: AudioStream, pitch_variance: float = 0.):
  if sample_loops.has(stream.resource_name): return
  sample_loops[stream.resource_name] = true
  while sample_loops.has(stream.resource_name):
    var pitch = randf_range(1.-pitch_variance, 1.+pitch_variance)
    await play_sound(stream, pitch, true)
    await get_tree().process_frame
    
func stop_sample_loop(stream:AudioStream):
  if sample_loops.has(stream.resource_name):
    if sample_loops[stream.resource_name] is bool: return
    sample_loops[stream.resource_name].stop()
    free.append(sample_loops[stream.resource_name])
    sample_loops.erase(stream.resource_name)
  
func lower_music_volume():
  if not music.playing or not music.stream: return
  target_db_music = -60.
  music.volume_db = target_db_music
  
func normal_music_volume():
  if not music.playing or not music.stream: return
  target_db_music = -40.
  music.volume_db = target_db_music

func _ready():
  music.process_mode = Node.PROCESS_MODE_ALWAYS
  add_child(music)
  for channel in 16:
    var p = AudioStreamPlayer.new()
    add_child(p)
    free.append(p)
    sound_players.append(p)
    p.finished.connect(_audio_finished.bind(p))
    p.bus = 'master'

func _audio_finished(stream: AudioStreamPlayer):
 free.append(stream)

func play_sound(sound: AudioStream, pitch_scale: float = 1., volume = 0,  save_player: bool = false):
  if free.is_empty(): return
  var player = free.pop_front() as AudioStreamPlayer
  player.stream = sound
  player.pitch_scale = pitch_scale
  player.volume_db = volume
  player.play()
  if save_player:
    sample_loops[sound.resource_name] = player
  await player.finished
