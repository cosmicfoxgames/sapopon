extends Control

@onready var sapo_img = %Sapo
@onready var label = %Label
@onready var texture = %NinePatchRect

@export var default_border_texture : Resource
@export var pressed_border_texture : Resource

var is_hovering = false

func _ready() -> void:
	set_itself(load("res://resources/frog_resources/frog_low_poly.tres"))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_click") and is_hovering == true:
		click()

func set_itself(frog : FrogTemplate):
	label.text = frog.id
	sapo_img.modulate = GameResources.FROG_COLLECTIONS_COLORS[GameData.FROG_COLECTIONS.keys()[frog.colection]]

func click():
	GlobalSignals.frog_icon_click.emit(label.text)
	GlobalSignals.play_sfx.emit(GameResources.get_resource(GameResources.SFX["DAMP_CLICK"]))

#signals

func _on_area_2d_mouse_entered() -> void:
	texture.texture = pressed_border_texture
	is_hovering = true
func _on_area_2d_mouse_exited() -> void:
	texture.texture = default_border_texture
	is_hovering = false
