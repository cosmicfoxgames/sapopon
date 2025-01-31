extends Control

signal button_click()

@export var button_txt : String
@export var hover_txt_color : Color
@export var down_txt_color : Color
@export var default_button_texture : Resource
@export var down_button_texture : Resource

@onready var label = %Label
@onready var texture = %NinePatchRect

var is_hovering = false

func _ready() -> void:
	set_button()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_click") and is_hovering == true:
		click_button()
	#if Input.is_action_just_released("game_click") and is_hovering == true:
		#texture.texture = default_button_texture
		#label.remove_theme_color_override("font_color")

func set_button():
	label.text = button_txt

func click_button():
	#GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.POINTER)
	texture.texture = down_button_texture
	label.add_theme_color_override("font_color", down_txt_color)
	button_click.emit()
	GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["DAMP_CLICK"]))
	
	await get_tree().create_timer(0.2).timeout
	texture.texture = default_button_texture
	label.remove_theme_color_override("font_color")

#signals

func _on_area_2d_mouse_entered() -> void:
	is_hovering = true
	label.add_theme_color_override("font_color", hover_txt_color)
	#GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.HAND)
func _on_area_2d_mouse_exited() -> void:
	is_hovering = false
	label.remove_theme_color_override("font_color")
	#GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.POINTER)
