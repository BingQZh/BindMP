extends KinematicBody2D

export(int) var wander_range = 32

export var SPAWN_MARGIN = 10
export var ACCELERATION = 700
export var MAX_SPEED = 100
export var ROLL_SPEED = 100
export var FRICTION = 500


var velocity = Vector2.ZERO
var direction =  Vector2.ZERO

puppet var puppet_pos
puppet var puppet_vel = Vector2()

func _physics_process(delta):
	if is_network_master():
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
		move_and_slide(velocity)
		rset_unreliable("puppet_pos", position)
		rset_unreliable("puppet_vel", velocity)
	else:
		position = puppet_pos
		velocity = puppet_vel
	
