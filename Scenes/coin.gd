extends RigidBody2D
@export var weight=5000

var speed = 100   #PlayerVariables.weight/weight
var rotation_speed = 20
@onready var player = get_node("../Player")
@onready var level = get_node("../Level")
signal push_collide
signal pull_collide
var colliding=false

func _ready():
	player.coin_push.connect(func():
		var player_direction = (self.position - player.global_position).normalized()
		apply_central_force(player_direction*speed)
		if (colliding == true):
			push_collide.emit()
			#print("signal sent")
		
	)
	player.coin_pull.connect(func():
		var player_direction = (self.position - player.global_position).normalized()
		apply_central_force(-player_direction*speed)
		if (colliding == true):
			pull_collide.emit()
	)
func _physics_process(delta):
	
	
	rotation_speed = linear_velocity.x/20+linear_velocity.y/20
	rotate(rotation_speed*delta)

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body is TileMap:
		colliding = true
		#print(colliding)


func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body is TileMap:
		colliding = false
		#print(colliding)
