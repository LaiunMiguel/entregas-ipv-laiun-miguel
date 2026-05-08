extends PlayerState



func enter() -> void:
	character._play_animation("death")
	character.deactivate_player()
	character.play_death()
	character.died.emit()


func exit() -> void:
	return

func update(delta: float) -> void:
	pass

func handle_input(_event: InputEvent) -> void:
	return


func handle_event(_event: StringName, _value = null) -> void:
	return

func _on_animation_finished(_anim_name: StringName) -> void:
	pass
