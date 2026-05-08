@abstract
extends AbstractState 
class_name AbstractEnemyState

var character: Turret

func handle_event(event: StringName, value = null) -> void:
	match event:
		"body_entered":
			handle_body_entered(value)
		"body_exited":
			handle_body_exited(value)


func handle_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		character.target = body
		character.animationPlayer.play("fire")

func handle_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		character.target = null
		
