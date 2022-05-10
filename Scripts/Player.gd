extends KinematicBody2D


var velocity: Vector2 = Vector2(0,0)
var SPEED: int = 500
var JUMP_SPEED: int = 800
var jump_count: int = 0 
var lives: int = 3
var has_won: bool = false
var world_limit: int = 1000


const UP: Vector2 = Vector2.UP
const GRAVITY: float = 50.0


# Called when the node enters the scene tree for the first time.
func _ready():
	update_gui()

func hurt():
	if lives > 0:
		lives = lives - 1
		update_gui()
	if lives <= 0:
		update_gui()
	
func enemy_jump():
	velocity.y = -JUMP_SPEED	

func _physics_process(delta):
	move()
	jump()
	apply_gravity()
	animate()
	move_and_slide(velocity, UP)
	
func move():
	if Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		velocity.x = SPEED
	else:
		velocity.x = 0 
		
func jump():
	if Input.is_action_pressed("Jump") and jump_count <= 1:
		velocity.y = -JUMP_SPEED
		jump_count = jump_count + 1
		$JumpSound.play()
	elif is_on_floor():
		jump_count = 0 

func apply_gravity():
	if not is_on_floor():
		velocity.y += GRAVITY
	if is_on_ceiling():
		velocity.y += GRAVITY * 2
		jump_count = 2
	if is_on_floor():
		velocity.y = 0
	if position.y >= world_limit:
		get_tree().call_group("GUI", "game_over")
		
func animate():
	if velocity.y < 0:
		$AnimatedSprite.play("Jump")
	elif velocity.x != 0 and velocity.x > 0:
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false
	elif velocity.x != 0 and velocity.x < 0:
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.play("Idle")
		
func update_gui():
	get_tree().call_group("GUI", "update_gui", lives, has_won) 
	
func win_condition():
	has_won = true
	update_winner()
	update_gui()
	
func update_winner():
	get_tree().call_group("EXIT", "update_winner", has_won)
