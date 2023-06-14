extends Area2D

onready var timer = $Timer
onready var anim = $AnimatedSprite


export var damage := 2


func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")
	connect("timeout", self, "attack_finished")
	anim.play("laser_attack")
	
func _on_body_entered(body: Node) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	

func attack_finished():
	queue_free()


func _on_Timer_timeout():
	attack_finished()
