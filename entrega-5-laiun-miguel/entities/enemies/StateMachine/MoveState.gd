extends AbstractEnemyState


func enter() -> void:
	character.play("idle")
	if character.pathfinding != null:
		var random_point :Vector2 = character.spawn_position  + Vector2(
			randf_range(-character.wander_radius.x, character.wander_radius.x), 
			randf_range(-character.wander_radius.y, character.wander_radius.y))
		
		var path = character.pathfinding.get_simple_path(character.global_position, random_point)

		if path.is_empty() || path.size() == 1:
			emit_signal("finished", "idle")
		else:
			character.path = path

	else :
		emit_signal("finished", "idle")


func exit() -> void:
	character.path.clear()


func handle_input(event: InputEvent) -> void:
	pass


func update(delta: float) -> void:

	if character._can_see_target():
		emit_signal("finished", "alert")
		return

	if !character.path.is_empty():
		var next_point = character.path.front()

		while character.global_position.distance_to(next_point) < character.pathfinding_step_threshold:
			character.path.pop_front()
			if character.path.is_empty():
				emit_signal("finished", "idle")
				return
			next_point = character.path.front()

		character.velocity = (character.velocity + character.global_position.direction_to(next_point) * character.speed).limit_length(character.max_speed)
		character._apply_movement()
	else :
		emit_signal("finished", "idle")




func _on_animation_finished(anim_name: StringName) -> void:
	pass

func handle_event(event: StringName, value = null) -> void:
	match event:
		"body_entered":
			handle_body_entered(value)
		"body_exited":
			handle_body_exited(value)


func handle_body_entered(body: Node2D) -> void:
	super.handle_body_entered(body)

func handle_body_exited(body: Node2D) -> void:
	super.handle_body_exited(body)
