extends KinematicBody2D

const BossDeathEffect = preload("res://Scenes/Enemy/BossDeathEffect.tscn")
const LaserCharge = preload("res://Scenes/Enemy/Laser_Charge.tscn")

var speed = 10
var motion = Vector2.ZERO
var player = null
var character_dir = "idle"
var target_rotation = null

onready var attack_timer = $AttackTimer
onready var anim = $AnimatedSprite
onready var stats = $Enemy_Stats
onready var hurtbox = $HurtBox
onready var laser_spawn = $AnimatedSprite/Position2D
onready var death_timer = $DeathTimer



func _ready():
	anim.play("idle")


func _physics_process(delta):
	
	motion = Vector2.ZERO
	if player == null:
		return
	elif is_instance_valid(player):
		motion = position.direction_to(player.position) * speed
		anim.play("idle")
		if (player.position.x - position.x) < 0:
			anim.flip_h = true
		elif (player.position.x - position.x) > 0:
			anim.flip_h = false
	motion = move_and_slide(motion)
	rotate_to_target()




func _on_Detection_body_entered(body):
	player = body
	attack_timer.start()


func _on_Detection_body_exited(player):
	player = null
	anim.play("idle")
	attack_timer.stop()

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	hurtbox.create_hit_effect()


func _on_Enemy_Stats_no_health():
	queue_free()
	var bossDeathEffect = BossDeathEffect.instance()
	get_parent().add_child(bossDeathEffect)
	bossDeathEffect.global_position = global_position
	death_timer.start()


func _on_DeathTimer_timeout():
	pass #run game over screen





func _on_AttackTimer_timeout():
	if player == null:
		return
	shoot_laser()



func shoot_laser():
	var laser = preload("res://Scenes/Enemy/Laser.tscn").instance()
	add_child(laser)
	print(laser)
	laser.global_transform = laser_spawn.global_transform
	laser.rotation = target_rotation



func rotate_to_target():
	var target_angle := PI / 2
	if is_instance_valid(player):
		target_angle = player.global_position.angle_to_point(global_position)
		target_rotation = target_angle




