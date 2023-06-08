extends Area2D

var current = load("res://Scripts/Player.gd").new()
onready var anim = get_parent().get_node("anim")


func attack():
	if direction == "right":
		anim.flip_h = false
		anim.play("side_attack")
		print("attack")
		
	if direction == "left":
		anim.flip_h = true
		anim.play("side_attack")
		print("attack")
		
	if direction == "down":
		anim.flip_h = true
		anim.play("front_walk")
		print("attack")

	if direction == "up":
		anim.flip_h = true
		anim.play("back_walk")
		print("attack")
