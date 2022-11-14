extends KinematicBody2D


var speed = 100
var acceleration = 500

var velocity = Vector2.ZERO

var direction = Vector2.UP

onready var animation_tree = $AnimationTree
onready var playback = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	velocity = move_and_slide(velocity)
	
	var move_input = Input.get_vector(
		"move_left", "move_right", "move_up", "move_down")
	
	velocity = velocity.move_toward(move_input * speed, acceleration)
	
	# animation
	
	if move_input.length_squared() > 0:
		direction = move_input.normalized()
	
	if velocity.length_squared() < 10:
		playback.travel("idle")
		
	else:
		playback.travel("move")
	animation_tree.set("parameters/idle/blend_position", direction)
	animation_tree.set("parameters/move/blend_position", direction)
