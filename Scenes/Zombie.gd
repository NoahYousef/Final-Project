extends KinematicBody2D


var speed = 50
var motion = Vector2.ZERO

var player = null


func _physics_process(delta):
	motion = Vector2.ZERO
	if player:
		motion = position.direction_to(player.position) * speed
	motion = move_and_slide(motion)






func _on_Detection_body_entered(body):
	player = body


func _on_Detection_body_exited(body):
	player = null
