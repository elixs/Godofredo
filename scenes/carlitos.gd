extends KinematicBody2D

enum State {
	MOVE,
	SWIM
}

#var Bullet = preload("res://scenes/bullet.tscn")
export(PackedScene) var Bullet

export(bool) var movement_enabled = true

var velocity = Vector2()

var GRAVITY = 10
var SPEED = 200
var JUMP_SPEED = 200
var SWIM_SPEED = 100
var ACCELERATION = 1000
var KICK_IMPULSE = 10

var jumps_available = 2

var state = State.MOVE setget _set_state


onready var pivot = $Pivot
onready var anim_player = $AnimationPlayer
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")
onready var bullet_spawn = $Pivot/BulletSpawn
onready var hud = $CanvasLayer/HUD
onready var settings_menu = $CanvasLayer/SettingsMenu
onready var pause_menu = $CanvasLayer/PauseMenu


func _ready():
	anim_tree.active = true
	pause_menu.connect("settings_pressed", self, "_on_settings_pressed")
	settings_menu.connect("close_pressed", self, "_on_close_pressed")



func _physics_process(delta):
	match state:
		State.MOVE:
			_move(delta)
		State.SWIM:
			_swim(delta)

func _move(delta):
	# movement
	
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI / 4, false)
	
	var move_input = Input.get_axis("move_left", "move_right")
	
#	if playback.get_current_node() == "fire":
#		move_input = 0
	if !movement_enabled:
		move_input = 0
	
	# velocity.x = lerp(move_input * SPEED, velocity.x, 0.99) 
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION * delta)
	velocity.y += GRAVITY
	
	if (is_on_floor() or jumps_available > 0) and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED
		jumps_available -= 1
	elif is_on_floor():
		jumps_available = 2
	
#	var last_collision = get_last_slide_collision()
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.collision_layer & 4:
			var enemy: Node2D = collision.collider
			var direction = (global_position - enemy.global_position).normalized()
			velocity = direction * SPEED * 2
			hud.lives -= 1
		var ball := collision.collider as Ball
		if ball:
			if ball.global_position.y < global_position.y + 12:
				print("kick")
				ball.apply_central_impulse(
					(-collision.normal + Vector2.UP * 0.5) * \
					 KICK_IMPULSE * velocity.length()
				)
	
		
	# animations
	
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		pivot.scale.x = 1
	
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		pivot.scale.x = -1
		
	if is_on_floor() and Input.is_action_just_pressed("fire"):
		playback.travel("fire")
		return
	
	if is_on_floor():
		if abs(move_input) !=0 or abs(velocity.x) > 50:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")
	

func _swim(delta):
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI / 4, false)
	
	var move_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	velocity = velocity.move_toward(move_input * SWIM_SPEED, ACCELERATION * delta)
	


func fire():
	var bullet = Bullet.instance()
	get_parent().add_child(bullet)
	bullet.global_position = bullet_spawn.global_position
	if pivot.scale.x == -1:
		bullet.rotation = PI

func _on_settings_pressed():
	pause_menu.hide()
	settings_menu.show()


func _on_close_pressed():
	pause_menu.show()
	settings_menu.hide()


func _set_state(value):
	
	if state == value:
		return

	match state:
		State.MOVE:
			print("I was moving")
	
	state = value
	
	match state:
		State.SWIM:
			print("I'm swimming now")

func swim():
	self.state = State.SWIM


func take_damage(instigator: Node2D):
	var direction = (global_position - instigator.global_position).normalized()
	velocity = direction  * SPEED
	hud.lives -= 1
	
	
