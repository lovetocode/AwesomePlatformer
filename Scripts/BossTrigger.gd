extends Area2D



func _on_BossTrigger_body_exited(body):
	if "Play" in body.name:
		get_parent().get_node("Bom").pause_mode = Node.PAUSE_MODE_PROCESS
		get_parent().get_node("Camera2D").position = get_parent().get_node("Player").position
		yield(get_tree(), "idle_frame")
		get_parent().get_node("Camera2D").current = true
		get_tree().paused = true
		get_parent().get_node("Player/Camera2D").smoothing_enabled = false
		tween_cam()
		yield(get_tree().create_timer(10),"timeout")
		get_tree().paused = false
		get_parent().get_node("Player/Camera2D").current = true
		get_parent().get_node("Player/Camera2D").smoothing_enabled = true
		get_parent().get_node("Bom").pause_mode = Node.PAUSE_MODE_INHERIT
		$CollisionShape2D.disabled = true

func tween_cam():
	var tween = get_parent().get_node("Tween")
	var anim_cam = get_parent().get_node("Camera2D")
	tween.interpolate_property(anim_cam, "position", 
	get_parent().get_node("Player").position, 
	Vector2(2700, 300),
	5, tween.TRANS_QUINT,
	tween.EASE_IN_OUT)
	
	tween.start()
	
	var text_anim = get_parent().get_node("ZombieText/AnimationPlayer")
	text_anim.play("TextAppear")
	
	yield(get_tree().create_timer(5),"timeout")
	
	text_anim.play_backwards("TextAppear")
	
	tween.interpolate_property(anim_cam, "position", 
	get_parent().get_node("Camera2D").position, 
	get_parent().get_node("Player").position,
	5, tween.TRANS_QUINT,
	tween.EASE_IN_OUT)
