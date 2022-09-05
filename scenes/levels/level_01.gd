extends Node2D


func _ready():
	Fade.fade_out()

func _input(event):
	if event.is_action_pressed("next_level"):
		Fade.fade_in()
#		yield(get_tree().create_timer(0.2), "timeout")
		yield(Fade, "fade")
		get_tree().change_scene("res://scenes/levels/level_02.tscn")
