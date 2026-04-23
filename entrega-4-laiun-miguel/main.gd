extends Node

@export  var player_char: PackedScene 

@onready var loseLabel = $GUI/LoseLabel
@onready var winLabel  = $GUI/WinLabel
@onready var camara    = $Camera2D
@onready var player    = $Player
@onready var playerSpawn = $playerSpawn

func _ready() -> void:
	player = player_char.instantiate()
	add_child(player)
	remove_child(camara)
	player.add_child(camara)
	player.position = playerSpawn.position
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()


func player_die():
	loseLabel.show()
	var fire_tween = create_tween()
	label_animation(loseLabel)

func player_won():
	winLabel.show()
	var fire_tween = create_tween()
	label_animation(winLabel)
	
func label_animation(label):
	var fire_tween = create_tween()
	fire_tween.set_loops()
	
	fire_tween.tween_property(label, "scale", Vector2(1.25,1.25), 1.0)
	fire_tween.tween_property(label, "scale", Vector2(0.75,0.75), 1.0)
	
	
func _on_killer_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.get_hit()


func _on_win_trigger_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.win()
		player_won()
