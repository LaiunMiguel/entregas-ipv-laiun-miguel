extends Node

@onready var loseLabel = $GUI/LoseLabel


func _on_killer_body_entered(body: Node2D) -> void:
	body.get_hit()

func player_die():
	loseLabel.show()
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
