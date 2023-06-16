extends AnimatedSprite

var stats = PlayerStats
onready var anim = $health_potion


func _ready():
	anim.play("idle")



func _on_Area2D_body_entered(body):
	stats.health = 8
	print("hello")
