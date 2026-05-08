extends AbstractEnemyState 

@onready var idle_timer: Timer = $IdleTimer


func enter() -> void:
	idle_timer.start()
	character.play("idle")
	


func exit() -> void:
	idle_timer.stop()


func handle_input(event: InputEvent) -> void:
	pass


func update(delta: float) -> void:
	character._apply_movement()

	if character._can_see_target():
		emit_signal("finished", "alert")
	


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
	character.play("idle")
	character.idle_timer.start()


func _on_idle_timer_timeout() -> void:
	emit_signal("finished", "move")
