extends Node2D

@onready var tutorial_key: Node2D = $TutorialKey
@onready var tutorial_key_2: Node2D = $TutorialKey2
@onready var tutorial_key_3: Node2D = $TutorialKey3

var shown := false

func _on_tutorial_body_entered(body: Node2D) -> void:
	if shown:
		return

	shown = true

	var tutorials = [
		tutorial_key,
		tutorial_key_2,
		tutorial_key_3
	]

	for tutorial in tutorials:
		tutorial.show()
		tutorial._act_key_name()
		tutorial.modulate.a = 0
		tutorial.position.y += 50

	var tween = create_tween()

	for tutorial in tutorials:
		tween.parallel().tween_property(tutorial, "modulate:a", 1.0, 0.5)
		tween.parallel().tween_property(tutorial, "position:y", tutorial.position.y - 50, 0.5)

	tween.tween_interval(20.0)
