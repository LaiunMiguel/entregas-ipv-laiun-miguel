@tool
extends Control


@export var action_id    : StringName
@export var action_name  : StringName : set = _set_action_name


@onready var button: Button = %Button
@onready var label: Label = %Label

func _ready() -> void:
	set_process_input(false)
	if !Engine.is_editor_hint() && InputMap.has_action(action_id):
		var event = InputMap.action_get_events(action_id)[0]
		_set_event(event)

func _on_button_pressed() -> void:
	set_process_input(true)
	button.text = "..."
	button.release_focus()


func _input(event: InputEvent) -> void:
	if !event is InputEventMouseMotion:
		InputMap.action_erase_events(action_id)
		InputMap.action_add_event(action_id, event)
		_set_event(event)
		set_process_input(false)
		GameState.notify_input_map_changed()
		await get_tree().create_timer(0.1).timeout
		button.grab_focus()
		
func _set_event(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		button.text = event.as_text().get_slice(":", 1).get_slice(",", 0).get_slice("=", 1)
	else:
		button.text = event.as_text()
		
func _set_action_name(name:String):
	action_name = name
	if has_node("%Label"):
		%Label.text = action_name
