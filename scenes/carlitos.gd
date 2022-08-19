extends KinematicBody2D

var velocity = Vector2()

var GRAVITY = 10
var SPEED = 200
var JUMP_SPEED = 200
var ACCELERATION = 300

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Input.get_axis("move_left", "move_right")
	
	# velocity.x = lerp(move_input * SPEED, velocity.x, 0.99) 
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION * delta)
	velocity.y += GRAVITY
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
