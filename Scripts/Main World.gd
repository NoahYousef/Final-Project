extends Node2D


#onready var sprite := $AnimatedSprite

func _ready():
	#$AnimatedSprite.play("Torch")
	pass


func _on_BossEntrance_body_entered(body):
	pass # Replace with function body.
	print(body)
	get_tree().change_scene("res://Scenes/World/Boss Arena.tscn")	
