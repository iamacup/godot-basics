extends RigidBody2D

export var min_speed = 150
export var max_speed = 250
var mob_types = ["walk", "swim", "fly"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	$Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")

func _on_Visibility_screen_exited():
	queue_free()
