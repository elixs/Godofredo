extends KinematicBody2D


func take_damage(instigator: Node2D):
	print("oh no!")
	print((global_position - instigator.global_position).normalized())
