extends KinematicBody2D

const SPEED = 300
var velocity = Vector2()

puppetsync var puppet_pos
puppetsync var puppet_vel = Vector2()

func _ready():
	var player_id = get_network_master()
	$NameLabel.text = gamestate.players[player_id]
	puppet_pos = position # Just making sure we initilize it

func _process(delta):
	# Sync to last known position and velocity
	position = puppet_pos
	velocity = puppet_vel
	position += velocity * delta
	puppet_pos = position

remotesync func spawn_bullet(faceDirection,spawn_pos):
	print("Server: Spawn bullets")
	var bulletInstance = load("res://Bullet.tscn").instance()
	bulletInstance.direction = faceDirection
	bulletInstance.global_position = faceDirection * bulletInstance.SPAWN_MARGIN + spawn_pos
	$Bullets.add_child(bulletInstance) 
