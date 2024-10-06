extends Resource

class_name EnemyWave

enum Direction {
  NORTH,
  SOUTH,
  WEST,
  EAST,
  NORTHWEST,
  NORTHEAST,
  SOUTHWEST,
  SOUTHEAST
}

@export var directions: Array[Direction]
@export var spawns: Array[EnemySpawn]
@export var duration_seconds: float
