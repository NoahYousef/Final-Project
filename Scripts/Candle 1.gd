extends StaticBody2D


onready var sprite := $SingleCandle

func _ready():
	$SingleCandle.play("SingleCandle")
