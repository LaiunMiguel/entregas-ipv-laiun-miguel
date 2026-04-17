extends Node

@export var enemy_scene: PackedScene


func _ready() -> void:
	spawn_all()

func spawn_all():
	for spawn in self.get_children():
		var turret = enemy_scene.instantiate()
		turret.global_position = spawn.global_position
		add_child(turret)
