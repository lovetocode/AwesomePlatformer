extends Node2D



#func _on_AnimationPlayer_animation_finished(anim_name):
#	queue_free()


func _on_Area2D_body_entered(body):
	if "Play" in body.name:
		Global.points = Global.points + 1
		$JewelCollected.play()
		$AnimationPlayer.play("Obtained")
		$Area2D/CollisionShape2D.disabled = true
		Global.jewelCount = Global.jewelCount + 1
		yield(get_tree().create_timer(0.1), "timeout")
		queue_free()
		
