extends CanvasLayer

func _ready():
	add_to_group("GUI")
	
	
func _input(event):
	if event.is_action_pressed("Pause"):
		var pause_state = not get_tree().paused
		get_tree().paused = pause_state
		$PauseScreen.visible = pause_state
	
func _process(delta):
	jewel_collected()
	
func update_gui(lives, has_won):
	if lives <= 0:
		game_over()
	if has_won == true:
		$KeyGreen.show()
	$Lives.text = "Lives: " + str(lives)
		
func jewel_collected():
	if Global.jewelCount == 1:
		$CollectedJewels/GreenJewel.show()
	if Global.jewelCount == 2:
		$CollectedJewels/GreenJewel2.show()
	if Global.jewelCount == 3:
		$CollectedJewels/GreenJewel3.show()
		
		
func _on_PlayAgain_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_Quit_pressed():
	get_tree().quit()

func winner():
	$Winner.show()
	get_tree().paused = true
	
	
func game_over():
	$PopupDialog.show()
	get_tree().paused = true
	
func _on_Play_Again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
