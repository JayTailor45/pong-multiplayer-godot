extends StaticBody2D

@export var player_id := 1:
	set(id):
		player_id = id

const paddle_speed: int = 500

var win_height: int
var p_height: int

func _ready() -> void:
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y


func _process(delta: float) -> void:
	if Input.is_action_pressed('ui_up'):
		position.y -= paddle_speed * delta
	elif Input.is_action_pressed('ui_down'):
		position.y += paddle_speed * delta
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
