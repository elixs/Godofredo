extends MarginContainer

onready var play = $VBoxContainer/Play
onready var credits = $VBoxContainer/Credits
onready var exit = $VBoxContainer/Exit
onready var settings = $VBoxContainer/Settings



func _ready():
	play.connect("pressed", self, "_on_play_pressed")
	settings.connect("pressed", self, "_on_settings_pressed")
	credits.connect("pressed", self, "_on_credits_pressed")
	exit.connect("pressed", self, "_on_exit_pressed")


func _on_play_pressed():
	Fade.fade_in()
	yield(Fade, "fade")
	get_tree().change_scene("res://scenes/levels/level_01.tscn")


func _on_settings_pressed():
	pass
	

func _on_credits_pressed():
	print("· o ·)")


func _on_exit_pressed():
	get_tree().quit()
