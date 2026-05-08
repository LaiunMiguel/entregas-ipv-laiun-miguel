extends CharacterBody2D
class_name Turret



@onready var timer  = $FireTimer
@onready var animationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var BulletScene: PackedScene


# Variables para pathfinding
@export var pathfinding: PathfindAstar
@export var pathfinding_step_threshold: float = 16.0

#STATS
@export var speed: float = 5
@export var max_speed : float = 35
@export var wander_radius: Vector2 = Vector2(64,64)


var spawn_position: Vector2


var path: Array = []

var target:Node2D = null


func _ready() -> void:
	animated_sprite_2d.play("idle")
	
func play(animationName:String):
	match animationName:
		"idle":
			animated_sprite_2d.play("idle")
			animationPlayer.stop()
		"fire":
			animationPlayer.play("fire")
		

func _apply_movement():
	move_and_slide()	

func _can_see_target() -> bool:
	if target:
		return true
	return false

func _look_at_target():
	if target:
		animated_sprite_2d.flip_h = target.position.x > position.x

	
	

func _on_fire_timer_timeout() -> void:
	if is_instance_valid(target):
		try_shoot()
		
func try_shoot() -> void:
	if has_line_of_sigth():
		shoot()
	
func has_line_of_sigth() -> bool:
	var space_state = get_world_2d().direct_space_state
	
	var query = PhysicsRayQueryParameters2D.create(global_position,target.global_position)
	var result = space_state.intersect_ray(query)
	
	return result.is_empty() || result.collider == target 

func shoot():
	var target_pos = target.global_position
	var bullet = BulletScene.instantiate()
	bullet.global_position = global_position
	var direction = (target_pos - global_position).normalized()
	bullet.direction = direction
	get_tree().current_scene.add_child(bullet)
	
