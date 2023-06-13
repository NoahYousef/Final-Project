extends KinematicBody2D

#set constants
export var SPEED := 100.0

#set variables
var drag_factor := 0.3
var velocity := Vector2.ZERO
var current_dir = "none"
var in_combat = false

onready var anim := $AnimatedSprite
onready var animplayer := $AnimationPlayer
onready var swordHitbox = $SwordHitbox


func _ready():
	anim.play("front_idle")



func _physics_process(delta: float) -> void:
	player_movement(delta)
	attack()
	
	
func player_movement(delta):
	var direction := Vector2.ZERO
	if in_combat == false:
		if Input.is_action_pressed("ui_right"):
			current_dir = "right"
			play_animation(1)
			direction.x = 1.0
			swordHitbox.knockback_vector = direction
			
		elif Input.is_action_pressed("ui_left"):
			current_dir = "left"
			play_animation(1)
			direction.x = -1.0
			swordHitbox.knockback_vector = direction
			
		elif Input.is_action_pressed("ui_up"):
			current_dir = "up"
			play_animation(1)
			direction.y = -1.0
			swordHitbox.knockback_vector = direction
			
		elif Input.is_action_pressed("ui_down"):
			current_dir = "down"
			play_animation(1)
			direction.y = 1.0
			swordHitbox.knockback_vector = direction
			
		else:
			play_animation(0)

		var desired_velocity := SPEED * direction
		var steering_vector := desired_velocity - velocity
		velocity += steering_vector * drag_factor
		velocity = move_and_slide(velocity)


func play_animation(movement):
	var direction = current_dir
	
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
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
			
	if direction == "up":
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")


func attack():
	if Input.is_action_just_pressed("attack"):
		in_combat = true
		if current_dir == "right":
			anim.flip_h = false
			$SwordHitbox/right.disabled = false
			anim.play("side_attack")
			print("attack right")
			
		if current_dir == "left":
			anim.flip_h = true
			$SwordHitbox/left.disabled = false
			anim.play("side_attack")
			print("attack l")
			
		if current_dir == "up":
			$SwordHitbox/up.disabled = false
			anim.play("back_attack")
			print("attack u")
			
		if current_dir == "down":
			$SwordHitbox/down.disabled = false
			anim.play("front_attack")
			print("attack d") 
	


func _on_AnimatedSprite_animation_finished():
	if anim.animation == "side_attack":
		in_combat = false
		$SwordHitbox/right.disabled = true
		$SwordHitbox/left.disabled = true
	if anim.animation == "front_attack":
		in_combat = false
		$SwordHitbox/down.disabled = true
	if anim.animation == "back_attack":
		in_combat = false
		$SwordHitbox/up.disabled = true
