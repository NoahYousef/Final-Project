extends KinematicBody2D

const BossDeathEffect = preload("res://Scenes/Enemy/BossDeathEffect.tscn")


var speed = 10
var motion = Vector2.ZERO
var player = null
var character_dir = "idle"


onready var attack_timer = $AttackTimer
onready var anim = $AnimatedSprite
onready var stats = $Enemy_Stats
onready var hurtbox = $HurtBox
onready var laser_spawn = $AnimatedSprite/Position2D
var target_rotation = null



func _ready():
	anim.play("idle")


func _physics_process(delta):
	
	motion = Vector2.ZERO
	if player:
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


func _on_AttackTimer_timeout():
	if player == null:
		return
	var laser = preload("res://Scenes/Enemy/Laser.tscn").instance()
	add_child(laser)
	print(laser)
	laser.global_transform = laser_spawn.global_transform
	laser.rotation = target_rotation


func rotate_to_target():
	var target_angle := PI / 2
	if player:
		target_angle = player.global_position.angle_to_point(global_position)
		target_rotation = target_angle
