extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()


func _on_Area2D_body_entered(body):
	if "Player" in body.name:
		Global.points = Global.points + 1
		$AnimationPlayer.play("Obtain")
		$Area2D/CollisionShape2D.disabled = true
		print(Global.points)
