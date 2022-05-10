extends Node2D



func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		body.win_condition()
		$KeyCollected.play()
		yield(get_tree().create_timer(0.1), "timeout")
		queue_free()
		


#func _on_KeyCollected_finished():
#	queue_free()
