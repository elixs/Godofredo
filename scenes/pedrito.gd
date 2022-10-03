extends KinematicBody2D


var mouse_inside = false
var move_with_mouse = false


func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")

func _on_mouse_entered():
	mouse_inside = true


func _on_mouse_exited():
	mouse_inside = false


func _input(event):
	if event.is_action_pressed("grab") and mouse_inside:
		move_with_mouse = true
	if event.is_action_released("grab") and move_with_mouse:
		move_with_mouse = false


func _physics_process(delta):
	if move_with_mouse:
		global_position = get_global_mouse_position()


func take_damage(instigator: Node2D):
	print("oh no!")
	print((global_position - instigator.global_position).normalized())
