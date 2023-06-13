extends KinematicBody2D

const EnemyDeathEffect = preload("res://Scenes/EnemyDeathEffect.tscn")


var speed = 50
var motion = Vector2.ZERO
var knockback = Vector2.ZERO
var player = null
var character_dir = "idle"

onready var anim = $AnimatedSprite
onready var stats = $Enemy_Stats



func _ready():
	anim.play("side_idle")
	print(stats.max_health)
	print(stats.health)


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 100 * delta)
	knockback = move_and_slide(knockback)
	
	motion = Vector2.ZERO
	if player:
		motion = position.direction_to(player.position) * speed
		anim.play("side_walk")
		if (player.position.x - position.x) < 0:
			anim.flip_h = true
		elif (player.position.x - position.x) > 0:
			anim.flip_h = false
	motion = move_and_slide(motion)
	




func _on_Detection_body_entered(body):
	player = body


func _on_Detection_body_exited(body):
	player = null
	anim.play("side_idle")

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 100
	

func _on_Enemy_Stats_no_health():
	queue_free()
	var enemyDeathEffect = EnemyDeathEffect.instance()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
