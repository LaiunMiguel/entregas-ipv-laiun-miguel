extends Sprite2D

@onready var timer  = $FireTimer
@export var BulletScene: PackedScene

var target:Node2D = null

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
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	target = body


func _on_area_2d_body_exited(body: Node2D) -> void:
	target = null

func _on_hurt_box_area_entered(area: Area2D) -> void:
		area.get_parent().queue_free()
		queue_free()
	
