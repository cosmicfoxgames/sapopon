extends Resource
class_name FrogTemplate

enum RARITY {COMMOM, INCOMMOM, RARE, UNIQUE}

@export var id : String
@export var colection : GameData.FROG_COLECTIONS
@export var frog_rarity : RARITY


func get_value():
	return(frog_rarity * frog_rarity)
