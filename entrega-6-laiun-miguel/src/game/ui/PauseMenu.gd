extends Control

## Menú de pausa genérico, abierto utilizando la acción "pause_menu"
## (por default la tecla Esc).
@onready var options_menu: Control = $OptionsMenu


##Signals
signal restart
signal main_menu

func _ready() -> void:
	hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("pause_menu") && !options_menu.visible:
		visible = !visible
		get_tree().paused = visible


func _on_resume_button_pressed() -> void:
	hide()
	get_tree().paused = false



func _on_restart_button_pressed() -> void:
	get_tree().paused = false
	emit_signal("restart")

func _on_options_button_pressed() -> void:
	options_menu.show()

func _on_menu_button_pressed() -> void:
		emit_signal("main_menu")
