extends Control

@onready var frog_img = %"64x64"
@onready var frog_name = %frog_name

@onready var anim = %AnimationPlayer

var can_skip_already = false

func _ready() -> void:
	initiate_new_frog_anim(GameData.most_recent_frog)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("game_enter") and can_skip_already == true:
		hide_itself()

func initiate_new_frog_anim(frog : FrogTemplate):
	can_skip_already = false
	frog_name.text = frog.id
	frog_img.texture = frog.get_frog_img()
	
	anim.play("gacha_down")
	await anim.animation_finished
	anim.play("frgo_wiggle")
	
	await get_tree().create_timer(3).timeout
	
	can_skip_already = true

func hide_itself():
	visible = false
	get_tree().paused = false
