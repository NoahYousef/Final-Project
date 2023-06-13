extends KinematicBody2D


var speed = 30
var motion = Vector2.ZERO

var player = null
onready var anim = $AnimatedSprite

func _ready():
	anim.play("side_idle")


func _physics_process(delta):
	motion = Vector2.ZERO
	if player:
		motion = position.direction_to(player.position) * speed
		anim.play("side_walk")
	motion = move_and_slide(motion)
	






func _on_Detection_body_entered(body):
	player = body


func _on_Detection_body_exited(body):
	player = null
	anim.stop()

func _on_HurtBox_area_entered(area):
	pass
