extends StaticBody2D

@export var player_id := 1:
	set(id):
		player_id = id
		%InputSynchronizer.set_multiplayer_authority(id)

const paddle_speed: int = 500

var win_height: int
var p_height: int

func _appy_animations(delta):
	pass

func _apply_movement_from_input(delta):
	if %InputSynchronizer.is_up_key_pressed:
		position.y -= paddle_speed * delta
	elif %InputSynchronizer.is_down_key_pressed:
		position.y += paddle_speed * delta
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)

func _ready() -> void:
	win_height = get_viewport_rect().size.y
	p_height = $ColorRect.get_size().y
	if (player_id == 1):
		position.x = 30 
	else:
		position.x = 950

func _process(delta: float) -> void:
	if (multiplayer.is_server()):
		_apply_movement_from_input(delta)
