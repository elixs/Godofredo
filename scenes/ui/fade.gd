extends CanvasLayer

signal fade

onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.connect("animation_finished", self, "_on_animation_finished")


func fade_in():
	animation_player.play("fade_in")


func fade_out():
	animation_player.play("fade_out")


func _on_animation_finished(anim_name: String):
	emit_signal("fade")
