extends Area2D

#const HitEffect = preload("res://Effects/HitEffect.tscn")


var invincible = false setget set_invincible

onready var timer = $Timer
onready var collisionShape = $CollisionShape2D
signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
		
func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)
	

func _on_HitBox_invincibility_started():
	collisionShape.set_deferred("disabled", true)

func _on_HitBox_invincibility_ended():
	collisionShape.set_deferred("disabled", false)
