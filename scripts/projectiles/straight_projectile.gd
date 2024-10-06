extends Projectile

class_name StraightProjectile

func _process(delta):
  global_position += direction * speed * delta
