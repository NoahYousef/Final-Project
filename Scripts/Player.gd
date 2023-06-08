extends KinematicBody2D

#set constants
const SPEED := 100.0

#set variables
var drag_factor := 0.3
var velocity := Vector2.ZERO
var current_dir = "none"


onready var sprite := $AnimatedSprite
onready var weapon = $weapon

func _ready():
	$AnimatedSprite.play("front_idle")




func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	
	var direction := Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_animation(1)
		direction.x = 1.0
		
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_animation(1)
		direction.x = -1.0
		
	elif Input.is_action_pressed("ui_up"):
		current_dir = "up"
		play_animation(1)
		direction.y = -1.0
		
	elif Input.is_action_pressed("ui_down"):
		current_dir = "down"
		play_animation(1)
		direction.y = 1.0
		
	else:
		play_animation(0)

	var desired_velocity := SPEED * direction
	var steering_vector := desired_velocity - velocity
	velocity += steering_vector * drag_factor
	velocity = move_and_slide(velocity)


func play_animation(movement):
	var direction = current_dir
	var anim = $AnimatedSprite
	
	if direction == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
			
	if direction == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
			
	if direction == "down":
		anim.flip_h = true
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
			
	if direction == "up":
		anim.flip_h = true
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")



func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("attack"):
		weapon.attack()
		
	
