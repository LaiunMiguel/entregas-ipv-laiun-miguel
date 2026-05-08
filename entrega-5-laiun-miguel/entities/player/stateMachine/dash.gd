extends PlayerState

var time_left
var direction

func enter() -> void:
	direction = character.h_movement_direction
	
	#Si el player no se movio que dashee en la direccion que mira
	if direction == 0:
		if character.sprite.flip_h:
			direction = -1
		else:
			direction = 1
	
	
	character.velocity.x = direction * character.DASH_SPEED
	time_left = character.DASH_DURATION

	
		
func exit() -> void:
	return


func handle_input(event: InputEvent) -> void:
	if character.is_on_floor() && event.is_action_pressed("jump"):         
			finished.emit("jump")

func update(delta: float) -> void: 
	time_left -= delta
	character._apply_movement(delta)

	if time_left <= 0:
		if character.h_movement_direction != 0:
			finished.emit("move")
		else:
			finished.emit("idle")

	

func _on_animation_finished(anim_name: StringName) -> void:
	pass


func handle_event(event: StringName, value = null) -> void:
	match event:
		&"hit":
			character._handle_hit(value)
			if character.dead:
				finished.emit(&"death")
