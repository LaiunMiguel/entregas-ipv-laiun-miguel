extends CharacterBody2D

@onready var weapon_cont = $WeaponContainer
@onready var sprite: AnimatedSprite2D = $Sprite

#Character speed
@export var ACCELERATION: float = 1200.0 
@export var H_SPEED_LIMIT: float = 140.0
@export var jump_speed: int = 350
@export var FRICTION_WEIGHT: float = 8
@export var gravity: int = 800.0
@export var push_force: float = 80.0

var h_movement_direction: int = 0
var jump: bool = false

func _process(delta: float) -> void:
	#Manejo del arma
	if Input.is_action_just_pressed("shoot"):
		var weapon = weapon_cont.get_node("Weapon")
		sprite.flip_h = get_global_mouse_position().x < position.x
		ajust_flip()
		weapon.shoot()

func _physics_process(delta: float) -> void:
		
	_process_input()
	
	if h_movement_direction != 0:
		velocity.x = clamp(
			velocity.x + (h_movement_direction * ACCELERATION * delta),
			-H_SPEED_LIMIT,
			H_SPEED_LIMIT
		)
		sprite.flip_h = !h_movement_direction == 1
		ajust_flip()	
		
		sprite.play("move")
	else:
		velocity.x = lerp(velocity.x, 0.0, FRICTION_WEIGHT * delta) if abs(velocity.x) > 1 else 0
		sprite.play("idle")
	
	if jump and is_on_floor():
		velocity.y -= jump_speed
	
	if !is_on_floor() && !sprite.animation == "jump":
		sprite.play("jump")

	velocity.y += gravity * delta
	
	for i in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			var collision_normal: Vector2 = collision.get_normal()
			var velocity_alignment: float = float(
				collision_normal.dot(-velocity.normalized()) > 0.0
			)
			collision.get_collider().apply_central_impulse(
				-collision_normal.slerp(-velocity.normalized(), 0.5) * push_force * velocity_alignment
			)
	
	move_and_slide()

func _process_input() -> void:

	jump = Input.is_action_just_pressed("jump")

	h_movement_direction = int(
		Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")
	)
	
func ajust_flip():
	if sprite.flip_h:
		weapon_cont.get_node("Weapon").change_pos(weapon_cont.get_node("Left").position)
	else: 
		weapon_cont.get_node("Weapon").change_pos(weapon_cont.get_node("Right").position)
		
	
func get_hit():
	deactivate_player()
	play_death()
	
func deactivate_player():
	set_physics_process(false)
	set_process(false)
	set_collision_layer_value(2,false)
	weapon_cont.visible = false

func play_death():
	sprite.play("death")
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(0,-50), 0.5).set_delay(0.5)
	tween.tween_property(self, "position", position + Vector2(0, 300), 1.2)
	await tween.finished
	get_parent().player_die()
	queue_free()

func win():
	deactivate_player()
	hide()
