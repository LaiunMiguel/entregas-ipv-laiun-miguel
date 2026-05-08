extends Node

@export var enemy_scene: PackedScene
@export var pathfinding: PathfindAstar

func _ready() -> void:
	spawn_all()

func spawn_all():
	
	for spawn in self.get_children():
		var turret : Node = enemy_scene.instantiate()
		turret.global_position = spawn.global_position
		turret.spawn_position = spawn.global_position
		turret.pathfinding = pathfinding
		add_child(turret)
