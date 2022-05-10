extends Node2D

var winner: bool = false

func _ready():
	add_to_group("EXIT")
	
func update_winner(has_won):
	winner = has_won

func _on_Area2D_body_entered(body):
	if "Player" in body.name and winner == true:
		$Unlock.play()
		yield(get_tree().create_timer(.3),"timeout")
		get_tree().call_group("GUI", "winner")
		
#func _on_Unlock_finished():
#	get_tree().call_group("GUI", "winner")
	
	
