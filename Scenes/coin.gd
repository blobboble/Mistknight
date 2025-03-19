extends RigidBody2D
@export var weight=5000

var speed = 100   #PlayerVariables.weight/weight
var rotation_speed = 20
@onready var player = get_node("../Player")
func _ready():
	player.coin_push.connect(func():
			var player_direction = (self.position - player.global_position).normalized()
			apply_central_force(player_direction*speed)
	)
	player.coin_pull.connect(func():
			var player_direction = (self.position - player.global_position).normalized()
			apply_central_force(-player_direction*speed)
		
	)
func _physics_process(delta):
	
	
	rotation_speed = linear_velocity.x/20+linear_velocity.y/20
	rotate(rotation_speed*delta)



#func _on_player_coin_push():
	#var player_distance = self.position - get_node("../Player").global_position
	#linear_velocity=player_distance*speed
