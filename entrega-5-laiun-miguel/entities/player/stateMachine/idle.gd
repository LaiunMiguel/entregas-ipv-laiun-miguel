extends PlayerState


# Al entrar se activa primero la animación "idle"
func enter() -> void:
	character._play_animation(&"idle")


func exit() -> void:
	return


func handle_input(event: InputEvent) -> void:
	if character.is_on_floor():
		if event.is_action_pressed("jump"):         
			finished.emit("jump")
		else:
			if event.is_action("dash"):
				finished.emit("dash")


# En esta función vamos a manejar las acciones apropiadas para este estado
func update(delta: float) -> void:
	# Vamos a querer que se pueda disparar
	character._handle_weapon_actions()
	
	# Vamos a permitir detectar inputs de movimiento
	character._handle_move_input(delta)
	# Para chequear si se realiza un movimiento
	if character.h_movement_direction != 0:
		# Y cambiamos el estado a walk
		finished.emit(&"move")
	else:
		# Si no se realiza movimiento, desaceleramos y manejamos movimiento
		character._handle_deacceleration(delta)
		character._apply_movement(delta)
		
		# Y aplicamos la animación apropiada, ya sea idle o saltar/caer
		if character.is_on_floor():
			character._play_animation(&"idle")
		else:
			if character.velocity.y > 0:
				character._play_animation(&"fall")
			else:
				character._play_animation(&"jump")


func _on_animation_finished(anim_name: StringName) -> void:
	return


# En este callback manejamos, por el momento, solo los impactos
func handle_event(event: StringName, value = null) -> void:
	match event:
		&"hit":
			character._handle_hit(value)
			if character.dead:
				finished.emit(&"death")
