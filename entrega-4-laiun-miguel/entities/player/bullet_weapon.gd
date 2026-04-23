extends CharacterBody2D


var VELOCITY = 150
var direction = Vector2.ZERO

@onready var sprite = $Sprite2D

func _ready() -> void:
	sprite.play("default")

func _physics_process(delta):

	#Ayudado por el video https://www.youtube.com/watch?v=Sw8MwqXBJZk
	var collision = move_and_collide(direction * VELOCITY * delta)
	if collision:
		direction = direction.bounce(collision.get_normal())
	
	sprite.flip_h = direction.x < 0
	position += direction * VELOCITY * delta
	
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_time_to_live_timeout() -> void:
	queue_free()
