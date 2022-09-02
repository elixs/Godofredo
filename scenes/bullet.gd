extends Area2D

var SPEED = 200

onready var visibility = $VisibilityNotifier2D
onready var timer = $Timer

func _ready():
	connect("body_entered", self, "_on_body_entered")
#	visibility.connect("screen_exited", self, "queue_free")
	timer.connect("timeout", self, "queue_free")
	
	timer.start()
	
	
	

func _physics_process(delta):
	position += SPEED * transform.x * delta


func _on_body_entered(body: Node):
#	body.is_in_group("enemy")
	if body.has_method("take_damage"):
		body.take_damage(self)
	queue_free()
