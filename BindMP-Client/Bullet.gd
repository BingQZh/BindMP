extends KinematicBody2D

export(int) var wander_range = 32

export var SPAWN_MARGIN = 10
export var ACCELERATION = 700
export var MAX_SPEED = 100
export var ROLL_SPEED = 100
export var FRICTION = 500


var velocity = Vector2.ZERO
var direction =  Vector2.ZERO


func _physics_process(delta):
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION)
	move_and_slide(velocity)	
