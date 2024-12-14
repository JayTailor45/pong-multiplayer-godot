extends CharacterBody2D

var win_size: Vector2

const start_speed: int = 500
const acc: int = 50

var speed: int
var dir: Vector2

var max_y_fac: float = 0.6

func _ready():
	win_size = get_viewport_rect().size
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(dir * speed * delta)
	var collider 
	if collision:
		collider = collision.get_collider()
		if collider == $"../Player" or collider == $"../AI Player":
			speed += acc
			dir = new_dir(collider)
		else:
			dir = dir.bounce(collision.get_normal())
	
func new_ball():
	position.x = win_size.x / 2
	position.y = randi_range(200, win_size.y - 200)
	speed = start_speed
	dir = random_dir()

func random_dir():
	var new_dir:= Vector2()
	new_dir.x = [1, -1].pick_random()
	new_dir.y = randf_range(-1, 1)
	return new_dir.normalized()

func new_dir(collider):
	var ball_y = position.y
	var paddle_y = collider.position.y
	var dist = ball_y - paddle_y
	var dirr := Vector2()
	
	if(dir.x > 0):
		dirr.x = -1
	else:
		dirr.x = 1
	dirr.y = (dist / (collider.p_height / 2)) * max_y_fac
	return dirr.normalized()
	
