extends StaticBody2D


onready var area_2d = $Area2D

var inside = []


func _ready():
	area_2d.connect("body_entered", self, "_on_body_entered")
#	area_2d.connect("body_exited", self, "_on_body_exited")


func _on_body_entered(body: Node):
	inside.append(body)
	if body.has_method("take_damage"):
		body.take_damage(self)


#func _on_body_exited(body: Node):
#	if inside.has(body):
#		inside.erase(body)
#
#
#func _physics_process(delta):
#	for body in inside:
#		if body.has_method("take_damage"):
#			body.take_damage(self)
