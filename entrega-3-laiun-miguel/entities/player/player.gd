extends CharacterBody2D

@onready var weapon = $Weapon
const SPEED = 300.0
const JUMP_VELOCITY = -600.0
const PUSH_FORCE = 150.0


func _process(delta: float) -> void:
	#Manejo del arma
	var mouse_pos = get_local_mouse_position()
	weapon.rotarArma(mouse_pos.angle()) 
	
	if Input.is_action_just_pressed("shoot"):
		weapon.shoot()
	
	

func _physics_process(delta: float) -> void:
	
	var direction_optimized:int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	
	if direction_optimized != 0:
		velocity.x += direction_optimized * SPEED * delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * delta * 5)

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			if abs(collision.get_normal().x) > 0.1:
				collider.apply_central_impulse(-collision.get_normal() * PUSH_FORCE)

	move_and_slide()
	
func get_hit():
	get_parent().player_die()
	queue_free()
