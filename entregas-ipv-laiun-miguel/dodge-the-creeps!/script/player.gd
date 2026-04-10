extends Area2D
signal hit

@export var speed = 400
var screen_size 

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _ready():
	screen_size = get_viewport_rect().size
	hide()
	
# _process se chequea en cada frame, 
#delta es usado para tener un tiempo consistente y no en base a solo a los frames 
func _process(delta: float):
	var velocity = Vector2.ZERO 
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		#Normalizar para cuando se aprete dos direcciones no tenga una velocidad mayor
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	#Clamp es para restringir , aca se restringe a la pantalla por eso se obtiene al hacer ready el tamaño
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	#set_deferred es para que godot espere hasta que termine el procesado de colisiones para desactivarlo 
	$CollisionShape2D.set_deferred("disabled", true)
	

	
