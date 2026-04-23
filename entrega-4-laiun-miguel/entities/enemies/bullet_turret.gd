extends Node2D

var VELOCITY = 150
var direction : Vector2 = Vector2.ZERO
@onready var sprite : AnimatedSprite2D= $AnimatedSprite

func _ready() -> void:
	sprite.play("default")
	sprite.flip_h = direction.x < 0
	
 
func _physics_process(delta):
	position += direction * VELOCITY * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.get_hit()
		queue_free()
