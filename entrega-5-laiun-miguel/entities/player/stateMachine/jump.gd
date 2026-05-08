extends PlayerState


func enter() -> void:
		character._play_animation(&"jump")
		character.velocity.y = - character.jump_speed
		
func exit() -> void:
	return


func handle_input(event: InputEvent) -> void:
	if event.is_action("dash"):
		finished.emit("dash")

func update(delta: float) -> void: 
	character._apply_movement(delta)
	character._handle_move_input(delta)
	
	if character.is_on_floor():
		finished.emit("idle")
	




func _on_animation_finished(anim_name: StringName) -> void:
	pass


func handle_event(event: StringName, value = null) -> void:
	match event:
		&"hit":
			character._handle_hit(value)
			if character.dead:
				finished.emit(&"death")
