extends MarginContainer


onready var button: Button = $HBoxContainer/VBoxContainer/Button

func _ready() -> void:
	button.grab_focus()
