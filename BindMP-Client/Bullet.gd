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
	print(direction)
	puppet_pos = position
	
func _physics_process(delta):
	print(velocity)
	if is_network_master():
		velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
		move_and_slide(velocity)	
		rset_unreliable("puppet_pos", position)
		rset_unreliable("puppet_vel", velocity)
	else:
		position = puppet_pos
		velocity = puppet_vel
	position += velocity * delta
	if not is_network_master():
		puppet_pos = position
		
func _on_Timer_timeout():
	queue_free()
