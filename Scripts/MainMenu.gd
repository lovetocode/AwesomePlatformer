extends Control

export(NodePath) var dropdown_path
onready var dropdown = get_node(dropdown_path)

func _ready():
	dropdown.connect("item_selected", self, "_on_item_selected")
	$Background/StartButton.connect("pressed", self, "_on_startbutton_pressed")
	add_item()

func add_item():
	dropdown.add_item("Windowed")
	dropdown.add_item("Fullscreen")
	
func _on_item_selected(id):
	if id == 0:
		OS.window_fullscreen = false
	if id == 1:
		OS.window_fullscreen = true
		
func _on_startbutton_pressed():
	get_tree().change_scene("res://Scenes/Level001.tscn")
