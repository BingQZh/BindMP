extends KinematicBody2D


export var SPAWN_MARGIN = 10
export var ACCELERATION = 700
export var MAX_SPEED = 100
export var FRICTION = 500

puppetsync var puppet_pos
puppetsync var puppet_vel = Vector2()
puppetsync var puppet_id

var velocity = Vector2.ZERO
var direction =  Vector2.ZERO
func _ready():
	puppet_pos = position # Just making sure we initilize it

func _physics_process(delta):
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	velocity = move_and_slide(velocity)	
	puppet_pos = position
	puppet_vel = velocity
	rset_unreliable("puppet_pos", position)
	rset_unreliable("puppet_vel", velocity)

func _on_Timer_timeout():
	queue_free()
