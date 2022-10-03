extends MarginContainer

signal close_pressed()

onready var fullscreen = $"%Fullscreen"
onready var music = $"%Music"
onready var sfx = $"%SFX"
onready var sfx_player = $SFXPlayer
onready var close = $VBoxContainer/Close


func _ready():
	fullscreen.connect("toggled", self, "_on_fullscreen_toggled")
	music.connect("value_changed", self, "_on_music_value_changed")
	sfx.connect("value_changed", self, "_on_sfx_value_changed")
	sfx.connect("drag_ended", self, "_on_drag_ended")
	close.connect("pressed", self, "_on_close_pressed")
	hide()


func _on_fullscreen_toggled(button_pressed: bool):
	OS.window_fullscreen = button_pressed


func _on_music_value_changed(value: float):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear2db(value)
	)


func _on_sfx_value_changed(value: float):
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear2db(value)
	)


func _on_drag_ended(value_changed: bool):
	sfx_player.play()


func _on_close_pressed():
	emit_signal("close_pressed")
