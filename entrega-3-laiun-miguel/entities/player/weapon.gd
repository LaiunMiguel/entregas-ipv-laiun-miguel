extends Node2D

@export var BulletScene: PackedScene
@onready var sprite = $WeaponSprite


func rotarArma(vector):
	sprite.rotation = vector

func shoot():
	var mouse_pos = get_global_mouse_position()
	var bullet = BulletScene.instantiate()
	bullet.global_position = global_position
	var direction = (mouse_pos - global_position).normalized()
	bullet.direction = direction
	
	get_tree().current_scene.add_child(bullet)
