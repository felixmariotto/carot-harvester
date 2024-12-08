extends Area2D

@export var speed = 400
const UP = Vector2( 0, -1 )
const DOWN = Vector2( 0, 1 )

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# compute the player velocity and move its position
	
	var velocity = Vector2()
	
	if ( Input.is_action_pressed("ui_down") ):
		velocity.y += 1
	if ( Input.is_action_pressed("ui_up") ):
		velocity.y -= 1
	if ( Input.is_action_pressed("ui_right") ):
		velocity.x += 1
	if ( Input.is_action_pressed("ui_left") ):
		velocity.x -= 1
	
	velocity = velocity.normalized()
	
	position += velocity * delta * speed
	
	# teleport the player to the other side of the viewport when out of bounds
	
	var viewport_rect = get_viewport_rect()
	
	if ( not viewport_rect.has_point( position ) ):
		if ( position.x <= viewport_rect.position.x ):
			position.x = viewport_rect.size.x - 1
		elif ( position.x >= viewport_rect.size.x ):
			position.x = viewport_rect.position.x + 1
		elif ( position.y >= viewport_rect.size.y ):
			position.y = viewport_rect.position.x + 1
		elif ( position.y <= viewport_rect.position.x ):
			position.y = viewport_rect.size.y - 1
	
	# update the sprite animation
	
	if ( velocity.length() == 0 ):
		$AnimatedSprite2D.stop()
	elif ( velocity == UP ):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk-up")
	elif ( velocity == DOWN ):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk-down")
	elif ( velocity.x >= 0 ):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("walk-right")
	else:
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("walk-right")
