extends KinematicBody2D

const BulletNode = preload("res://Bullet.tscn")

export var ACCELERATION = 500
export var MAX_SPEED = 80
export var ROLL_SPEED = 100
export var FRICTION = 500

var velocity = Vector2.ZERO
var faceDirection = Vector2.ZERO
var bulletSpawnSpot = Vector2.ZERO

puppet var puppet_pos
puppet var puppet_vel = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_network_master():
		$NameLabel.text = "You"
	else:
		var player_id = get_network_master()
		$NameLabel.text = gamestate.players[player_id]
		
		puppet_pos = position # Just making sure we initilize it


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_network_master():
		
		#if Input.is_action_just_pressed("Attack"): 
		
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
		input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		input_vector = input_vector.normalized()
		var move_dir = Vector2()
		
		if input_vector != Vector2.ZERO:
			velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION)
			faceDirection = velocity.normalized()
		else:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
			
		velocity = move_and_slide(velocity)
		
		rset_unreliable("puppet_pos", position)
		rset_unreliable("puppet_vel", velocity)
	else:
		# If we are not the ones controlling this player, 
		# sync to last known position and velocity
		position = puppet_pos
		velocity = puppet_vel
	
	position += velocity * delta
	
	if not is_network_master():
		# It may happen that many frames pass before the controlling player sends
		# their position again. If we don't update puppet_pos to position after moving,
		# we will keep jumping back until controlling player sends next position update.
		# Therefore, we update puppet_pos to minimize jitter problems
		puppet_pos = position
