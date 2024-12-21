extends MultiplayerSynchronizer

var is_up_key_pressed: bool
var is_down_key_pressed: bool

func _ready() -> void:
	
	if get_multiplayer_authority() != multiplayer.get_unique_id():
		set_process(false)
		set_physics_process(false)
	
	is_up_key_pressed = Input.is_action_pressed('ui_up')
	is_down_key_pressed = Input.is_action_pressed('ui_down')
	
func _process(delta: float) -> void:
	is_up_key_pressed = Input.is_action_pressed('ui_up')
	is_down_key_pressed = Input.is_action_pressed('ui_down')
