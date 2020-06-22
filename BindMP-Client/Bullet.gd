extends KinematicBody2D


export var SPAWN_MARGIN = 10
export var ACCELERATION = 700
export var MAX_SPEED = 100
export var FRICTION = 500

var velocity = Vector2.ZERO
var direction =  Vector2.ZERO

puppet var puppet_pos 
puppet var puppet_vel = Vector2()

func _ready():
	puppet_pos = position
	
func _physics_process(delta):
	position = puppet_pos
	position += velocity * delta
	puppet_pos = position
	
func _on_Timer_timeout():
	queue_free()
