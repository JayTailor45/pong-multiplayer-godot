extends Node

const SERVER_PORT = 8080
const SERVER_IP = "127.0.0.1"

var multiplayer_scene = preload("res://multiplayer_player.tscn")

var _players_spawn_node

func become_host():
	print("Hosting server...")
	
	_players_spawn_node = get_tree().current_scene.get_node("players")
	
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(SERVER_PORT)
	
	multiplayer.multiplayer_peer = server_peer
	
	multiplayer.peer_connected.connect(_add_player_to_game)
	multiplayer.peer_disconnected.connect(_del_player)
	_remove_single_player()
	_add_player_to_game(1)
	
func join_as_player_2():
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(SERVER_IP, SERVER_PORT)
	multiplayer.multiplayer_peer = client_peer
	_remove_single_player()

func _add_player_to_game(id: int):
	print("Player %s joined the game!" % id)
	
	var player_to_add = multiplayer_scene.instantiate()
	player_to_add.player_id = id
	player_to_add.name = str(id)
	
	_players_spawn_node.add_child(player_to_add, true)
	if id != 0:
		get_tree().current_scene.get_node("AI Player")

func _del_player(id: int):
	print("Player %s has left the game!" % id)
	if not _players_spawn_node.has_node(str(id)):
		return
	_players_spawn_node.get_node(str(id)).queue_free()
	
func _remove_single_player():
	print("Remove single player")
	var player_to_remove = get_tree().current_scene.get_node("Player")
	player_to_remove.queue_free()
