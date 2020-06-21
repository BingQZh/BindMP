extends Node2D

onready var Player = load("res://Player.tscn")
onready var BulletNode = load("res://Bullet.tscn")

puppet func spawn_player(spawn_pos, id):
	var player = Player.instance()
	
	player.position = spawn_pos
	player.name = String(id) # Important
	player.set_network_master(id) # Important
	
	$Players.add_child(player)

puppet func remove_player(id):
	$Players.get_node(String(id)).queue_free()
	
remote func spawn_bullet(faceDirection,spawn_pos):
	var bulletInstance = BulletNode.instance()
	bulletInstance.direction = faceDirection
	bulletInstance.global_position = faceDirection * bulletInstance.SPAWN_MARGIN + spawn_pos
	get_parent().add_child(bulletInstance)
