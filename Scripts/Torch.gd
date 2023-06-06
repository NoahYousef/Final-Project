extends StaticBody2D


onready var sprite := $Torch

func _ready():
	$Torch.play("Torch")

