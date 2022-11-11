extends PanelContainer

onready var label = $MarginContainer/Label

onready var text: String = ". - .)" setget set_text


func _ready():
	self.text = text
	hide()

func set_text(value: String):
	var was_visible = visible
	hide()
	text = value
	label.text = text
	var size = label.get_font("font").get_string_size(label.text)
	rect_size.x = size.x + 30
	rect_position.x = -(size.x + 30) / 2.0
	if was_visible:
		show()
