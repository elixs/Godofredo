extends KinematicBody2D


#var Bullet = preload("res://scenes/bullet.tscn")
export(PackedScene) var Bullet

export(bool) var movement_enabled = true

var velocity = Vector2()

var GRAVITY = 10
var SPEED = 200
var JUMP_SPEED = 200
var ACCELERATION = 1000


onready var pivot = $Pivot
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")

onready var bullet_spawn = $Pivot/BulletSpawn




func _ready():
	anim_tree.active = true


func _physics_process(delta):
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Input.get_axis("move_left", "move_right")
	
#	if playback.get_current_node() == "fire":
#		move_input = 0
	if !movement_enabled:
		move_input = 0
	
	# velocity.x = lerp(move_input * SPEED, velocity.x, 0.99) 
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION * delta)
	velocity.y += GRAVITY
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
	
		
	# Animations
	
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		pivot.scale.x = 1
	
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		pivot.scale.x = -1
		
	if is_on_floor() and Input.is_action_just_pressed("fire"):
		playback.travel("fire")
		return
	
	if is_on_floor():
		if abs(velocity.x) > 10:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")
	

func fire():
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.global_position = bullet_spawn.global_position
	if pivot.scale.x == -1:
		bullet.rotation = PI
