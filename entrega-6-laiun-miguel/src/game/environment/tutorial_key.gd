@tool 
extends Node2D

@onready var key_action: Label = %KeyAction
@onready var key: Label = %Key
@export  var key_id : StringName 


@export var key_action_name : StringName :
	set(value):
		key_action_name = value
		if has_node("%KeyAction"):
			key_action = %KeyAction
			key_action.text = key_action_name
			

func _ready() -> void:
	GameState.input_map_changed.connect(_act_key_name)
	_act_key_name()
	

func _act_key_name() -> void:
	if  InputMap.has_action(key_id):
		var keyName = InputMap.action_get_events(key_id)[0]
		if keyName is InputEventMouseButton:
			key.text = keyName.as_text().get_slice(":", 1).get_slice(",", 0).get_slice("=", 1)
		else:
			key.text = keyName.as_text()	
