extends Node2D

@export var BulletScene: PackedScene
@onready var sprite = $WeaponSprite
var tween : Tween

func _ready() -> void:
	sprite.play("idle")

func shoot_animation(vector :Vector2):
	if tween:
		tween.kill()
	sprite.play("fire")
	var angle = deg_to_rad(25)
	tween = create_tween()
	tween.tween_property(self, "rotation", angle, 0.2)
	tween.tween_property(self, "rotation", -angle, 0.2)
	tween.tween_property(self, "rotation", 0, 0.2)
	await tween.finished
	sprite.play("idle")

func change_pos(vector: Vector2):
	position = vector
		

func shoot():
	var mouse_pos = get_global_mouse_position()
	var bullet = BulletScene.instantiate()
	bullet.global_position = global_position
	var direction = (mouse_pos - global_position).normalized()
	bullet.direction = direction
	
	shoot_animation(direction)
	get_tree().current_scene.add_child(bullet)
