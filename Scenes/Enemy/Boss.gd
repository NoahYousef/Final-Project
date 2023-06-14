extends KinematicBody2D

const BossDeathEffect = preload("res://Scenes/Enemy/BossDeathEffect.tscn")


var speed = 10
var motion = Vector2.ZERO
var knockback = Vector2.ZERO
var player = null
var character_dir = "idle"


onready var anim = $AnimatedSprite
onready var stats = $Enemy_Stats
onready var hurtbox = $HurtBox


func _ready():
	anim.play("idle")
	print(stats.max_health)
	print(stats.health)


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 100 * delta)
	knockback = move_and_slide(knockback)
	
	motion = Vector2.ZERO
	if player:
		motion = position.direction_to(player.position) * speed
		anim.play("idle")
		if (player.position.x - position.x) < 0:
			anim.flip_h = true
		elif (player.position.x - position.x) > 0:
			anim.flip_h = false
	motion = move_and_slide(motion)
	




func _on_Detection_body_entered(body):
	player = body


func _on_Detection_body_exited(body):
	player = null
	anim.play("idle")

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 60
	hurtbox.create_hit_effect()

func _on_Enemy_Stats_no_health():
	queue_free()
	var bossDeathEffect = BossDeathEffect.instance()
	get_parent().add_child(bossDeathEffect)
	bossDeathEffect.global_position = global_position
