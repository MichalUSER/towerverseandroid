extends Control

onready var tween = get_node('tween')
onready var online_menu = get_node('.')

onready var towers_container = get_node('towers_container')

onready var guilds_container = get_node('guilds_container')

var is_towers_tab: bool = false
var is_guilds_tab: bool = false

func _ready() -> void:
	Utils.log('OnlineMenu started.')
	
	setup_ui_server_values()

func _input(event):
	if event.is_action_pressed('ui_back'):
		if tween.is_active():
			return
		
		Socket.send_packet('logoutTraveller')
			
		get_tree().change_scene("res://assets/Scenes/StartMenu.tscn")

func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST:
		if tween.is_active():
			return
		
		Socket.send_packet('logoutTraveller')
		
		get_tree().change_scene("res://assets/Scenes/StartMenu.tscn")

func setup_ui_server_values() -> void:
	pass

func change_tab(tab_num: int) -> void:
	match tab_num:
		0:
			if not is_towers_tab:
				towers_container.visible = true
				
				guilds_container.visible = false
				
				#todo: yield and change variable states
				is_towers_tab = true
				is_guilds_tab = false
		1:
			if not is_guilds_tab:
				guilds_container.visible = true
				
				towers_container.visible = false
				
				is_guilds_tab = true
				is_towers_tab = false
				
		_:
			Utils.log('Invalid tab number provided to change_tab: ' + str(tab_num))

# Signals
func _on_bottom_guilds_button_pressed():
	change_tab(1)
