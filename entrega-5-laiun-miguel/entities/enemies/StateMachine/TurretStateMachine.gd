extends GenericStateMachine

@export var character: Node


func _setup() -> void:
	if character == null:
		printerr("%s: character is not defined!" % name)
	for state: AbstractEnemyState in states_list:
		state.character = character


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if !body.is_in_group("player"):
		body.queue_free()
		character.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	current_state.handle_event("body_entered",body)


func _on_area_2d_body_exited(body: Node2D) -> void:
	current_state.handle_event("body_exited",body)
