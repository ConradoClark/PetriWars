extends Node

class_name SetMusic

@export var song: AudioStream
@export var muffled: AudioStream

func _ready():
  SoundManager.set_music(song, muffled)
  pass
