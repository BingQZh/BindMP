extends Node2D

onready var BulletNode = load("res://Bullet.tscn")

onready var Player = load("res://Player.tscn")


puppetsync func spawn_player(spawn_pos, id):
	var player = Player.instance()
	
	player.position = spawn_pos
	player.name = String(id) # Important
	player.set_network_master(id) # Important
	
	$Players.add_child(player)


puppetsync func remove_player(id):
	$Players.get_node(String(id)).queue_free()
	
puppetsync func spawn_bullet(spawn_pos, faceDirection):
	var bulletInstance = BulletNode.instance()
	bulletInstance.direction = faceDirection
	bulletInstance.global_position = faceDirection * bulletInstance.SPAWN_MARGIN + spawn_pos
	get_parent().add_child(bulletInstance) 
