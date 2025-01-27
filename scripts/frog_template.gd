extends Resource
class_name FrogTemplate

const FROG_IMG_PATH = "res://resources/graphics/frogs/%s.png"

enum RARITY {COMMOM, INCOMMOM, RARE, UNIQUE}

@export var id : String
@export var colection : GameData.FROG_COLECTIONS
@export var frog_rarity : RARITY

func get_value():
	return((frog_rarity + 1) * (frog_rarity + 1))

func get_frog_img():
	print("veio pro get_frog_img")
	print(FROG_IMG_PATH % id)
	print(FROG_IMG_PATH)
	print(id)
	return(load(FROG_IMG_PATH % id))
