extends Control

signal button_click(button)

@onready var icon = %icon
@onready var label = %Label
@onready var texture = %NinePatchRect

@export var icon_to_use : Resource
@export var button_txt : String
@export var default_button_texture : Resource
@export var pressed_button_texture : Resource

var is_hovering = false
var frog_res : FrogTemplate

func _ready() -> void:
	set_itself()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_click") and is_hovering == true:
		click()

func set_itself():
	label.text = button_txt
	if icon_to_use != null: icon.texture = icon_to_use

func set_frog(frog : FrogTemplate):
	label.text = frog.id
	icon.modulate = GameResources.FROG_COLLECTIONS_COLORS[GameData.FROG_COLECTIONS.keys()[frog.colection]]
	frog_res = frog
	label.add_theme_color_override("font_color", Color.WHITE)

func click():
	GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.POINTER)
	GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["DAMP_CLICK"]))
	button_click.emit(self)

#signals

func _on_area_2d_mouse_entered() -> void:
	texture.texture = pressed_button_texture
	is_hovering = true
	GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.HAND)
func _on_area_2d_mouse_exited() -> void:
	texture.texture = default_button_texture
	is_hovering = false
	GameData.change_mouse_pointer(GameData.MOUSE_POINTERS.POINTER)
