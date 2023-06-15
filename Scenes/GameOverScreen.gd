extends CanvasLayer


func _on_Restart_pressed():
	var new = get_tree().change_scene("res://Scenes/World/Main World.tscn")
	print(new)
	get_tree().change_scene("res://Scenes/World/Main World.tscn")
	
#	# It is now safe to remove the current scene
#	var current_scene = get_tree().current_scene
#	print(current_scene)
#	get_tree().current_scene.queue_free()
#
#	# Load the new scene.
#	var s = ResourceLoader.load("res://Scenes/World/Main World.tscn")
#
#	# Instance the new scene.
#	current_scene = s.instance()
#
#	# Add it to the active scene, as child of root.
#	get_tree().root.add_child(current_scene)
#
#
#	print("yo")
