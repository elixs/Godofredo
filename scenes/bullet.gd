extends Area2D

var SPEED = 200

var bodies_inside = []

onready var visibility = $VisibilityNotifier2D
onready var timer = $Timer

func _ready():
	connect("body_entered", self, "_on_body_entered")
#	connect("body_exited", self, "_on_body_exited")
#	visibility.connect("screen_exited", self, "queue_free")
	timer.connect("timeout", self, "queue_free")
	
	timer.start()
	
	
	

func _physics_process(delta):
	position += SPEED * transform.x * delta


func _on_body_entered(body: Node):
#	body.is_in_group("enemy")
#	bodies_inside.append(body)
	if body.has_method("take_damage"):
		body.take_damage(self)
	queue_free()


#func _on_body_exited(body: Node):
#	if body in bodies_inside:
#		bodies_inside.erase(body)
