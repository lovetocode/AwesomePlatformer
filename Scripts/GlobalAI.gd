extends KinematicBody2D

const SPEED: int = 80
const GRAVITY: int = 50
const UP: Vector2 = Vector2.UP

var velocity: Vector2 = Vector2.ZERO
var direction: int = 1
var is_dead: bool = false


func _process(delta):
	Movement()
	
func Death():
	is_dead = true
	$AnimatedSprite.play("Dead")
	$CollisionShape2D.disabled = true
	$EnemyDamage/CollisionShape2D.disabled = true
	$PlayerDamage/CollisionShape2D.disabled = true
	velocity.x = 0 
	yield(get_tree().create_timer(1),"timeout")
	queue_free()
	
func Movement():
	if is_dead == false:
		velocity.x = SPEED * direction
		
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
	
	$AnimatedSprite.play("Walk")
	
	velocity.y += GRAVITY
	
	move_and_slide(velocity, UP)
	
	if is_on_wall():
		direction = direction * -1
		$RayCast2D.position.x *= -1

	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1


func _on_PlayerDamage_body_entered(body):
	if "Player" in body.name:
		body.hurt()


func _on_EnemyDamage_body_entered(body):
	if "Player" in body.name:
		$PlayBounce.play()
		body.enemy_jump()
		Death()
