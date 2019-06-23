extends Area2D

signal hit

export var speed = 400
var screen_size

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	connect("body_entered", self, "_on_Player_body_entered")
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var velocity = Vector2()  # The player's movement vector.
    if Input.is_action_pressed("ui_right"):
        velocity.x += 1
    if Input.is_action_pressed("ui_left"):
        velocity.x -= 1
    if Input.is_action_pressed("ui_down"):
        velocity.y += 1
    if Input.is_action_pressed("ui_up"):
        velocity.y -= 1

    if velocity.length() > 0:
        velocity = velocity.normalized() * speed
        $AnimatedSprite.play()
    else:
        $AnimatedSprite.stop()
    
    var widthOffset = $CollisionShape2D.shape.radius
    var heightOffset = $CollisionShape2D.shape.radius + ($CollisionShape2D.shape.height/2)
    
    position += velocity * delta
    position.x = clamp(position.x, widthOffset, screen_size.x - widthOffset)
    position.y = clamp(position.y, heightOffset, screen_size.y - heightOffset)

    if velocity.x !=0:
        $AnimatedSprite.animation = "right"
        $AnimatedSprite.flip_v = false
        $AnimatedSprite.flip_h = velocity.x < 0
    
    if velocity.y != 0:
        $AnimatedSprite.animation = "up"
        $AnimatedSprite.flip_v = velocity.y > 0
		
func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true) # disable hit collision so we dont keep emiting hit signals
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	
	