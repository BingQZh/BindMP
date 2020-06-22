extends Node2D

onready var BulletNode = load("res://Bullet.tscn")
onready var Player = load("res://Player.tscn")
var bulletCount = 0;

puppetsync func spawn_player(spawn_pos, id):
	var player = Player.instance()
	
	player.position = spawn_pos
	player.name = String(id) # Important
	player.set_network_master(id) # Important
	
	$Players.add_child(player)


puppetsync func remove_player(id):
	$Players.get_node(String(id)).queue_free()
	
puppetsync func spawn_bullet(faceDirection,spawn_pos):
	var bulletInstance = load("res://Bullet.tscn").instance()
	bulletInstance.direction = faceDirection
	bulletInstance.global_position = faceDirection * bulletInstance.SPAWN_MARGIN + spawn_pos
	$Bullets.add_child(bulletInstance) 

puppetsync func remove_bullet(bulletRef):
	bulletRef.queue_free()
