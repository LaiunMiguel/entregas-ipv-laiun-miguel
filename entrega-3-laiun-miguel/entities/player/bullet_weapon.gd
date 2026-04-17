extends Node2D


var VELOCITY = 800
var direction = Vector2.ZERO

func _physics_process(delta):
	position += direction * VELOCITY * delta
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
