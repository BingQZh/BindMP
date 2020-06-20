extends KinematicBody2D

export(int) var wander_range = 32

export var SPAWN_MARGIN = 10
export var ACCELERATION = 700
export var MAX_SPEED = 100
export var ROLL_SPEED = 100
export var FRICTION = 500

puppet var puppet_pos
puppet var puppet_vel = Vector2()


var velocity = Vector2.ZERO
var direction =  Vector2.ZERO

func _ready():
	puppet_pos = position # Just making sure we initilize it


func _physics_process(delta):
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	move_and_slide(velocity)	
	puppet_pos = position
