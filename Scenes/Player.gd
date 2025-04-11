extends CharacterBody2D

@export var coin : PackedScene
var speed = PlayerVariables.speed
var gravity = PlayerVariables.gravity
var jump_height = PlayerVariables.jump_height
var weight = PlayerVariables.weight
signal coin_push
signal coin_pull




		
func _on_push_collide(c):
	var coin_direction = (self.position - c.global_position).normalized()
	velocity+=(coin_direction*speed*0.5)
	print(coin_direction*speed*0.5)
	print("coin collide detected")
func _on_pull_collide(c):
	var coin_direction = (self.position - c.global_position).normalized()
	velocity=(-coin_direction*speed*0.5)
	print("coin collide detected")

func _physics_process(delta):
	velocity.y+=gravity*delta
	horizontal_movement()
	move_and_slide()
	player_animations()
	coin_interactions()

func horizontal_movement():
	var horizontal_input = Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left")
	velocity.x = horizontal_input*speed

func player_animations():
	if Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")
		$CoinBag.position.x =-5
		
	if Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
		$CoinBag.position.x =5
	if !Input.is_anything_pressed():
		$AnimatedSprite2D.play("idle")
func coin_interactions():
	if Input.is_action_pressed("ui_push"):
		coin_push.emit()
	if Input.is_action_pressed("ui_pull"):
		coin_pull.emit()

func _input(event):
	if event.is_action_pressed("ui_coin"):
		coin_throw()
		$AnimatedSprite2D.play("coin")
	if event.is_action_pressed("ui_jump") and is_on_floor():
		velocity.y+=jump_height
func coin_throw():
	var c=coin.instantiate()
	owner.add_child(c)
	c.push_collide.connect(func():
		_on_push_collide(c)
	)
	c.pull_collide.connect(func():
		_on_pull_collide(c)
	)
	c.transform=$CoinBag.global_transform
	
	
