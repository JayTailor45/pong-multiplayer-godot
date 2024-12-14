extends StaticBody2D

var ball_pos: Vector2
var dist: int
var move_by: int
var win_height: int
var p_height: int

func _ready() -> void:
	win_height = get_viewport().size.y
	p_height = $ColorRect.get_size().y
	
func _process(delta: float) -> void:
	ball_pos = $"../Ball".position
	dist = position.y - ball_pos.y
	
	if(abs(dist) > get_parent().paddle_speed * delta):
		move_by = get_parent().paddle_speed * delta * (dist/ abs(dist))
	else:
		move_by = dist
	
	position.y -= move_by
	
	position.y = clamp(position.y, p_height / 2, win_height - p_height / 2)
