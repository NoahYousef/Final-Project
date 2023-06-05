extends Node2D


onready var sprite := $AnimatedSprite



func _ready():
	$AnimatedSprite.play("Torch")
