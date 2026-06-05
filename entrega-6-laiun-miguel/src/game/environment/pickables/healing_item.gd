extends Node2D

@export var heal_amount: int = 15

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method(&"notify_heal"):
		body.notify_heal(heal_amount)
		call_deferred("queue_free")
