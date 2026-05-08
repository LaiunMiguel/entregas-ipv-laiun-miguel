extends AbstractEnemyState


@onready var fire_timer: Timer = $FireTimer

func enter() -> void:
	character.play("fire")
	character.velocity = Vector2.ZERO
	fire()
	fire_timer.start()

func fire() -> void:
	character.try_shoot()
	


func exit() -> void:
	fire_timer.stop()


func handle_input(event: InputEvent) -> void:
	pass


func update(delta: float) -> void:
	character._look_at_target()
	


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
	emit_signal("finished", "idle")
	



func _on_fire_timer_timeout() -> void:
	if character._can_see_target():
		fire()
		fire_timer.start()
