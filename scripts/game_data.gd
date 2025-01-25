extends Node

enum FROG_COLECTIONS {GOTHIC, WILD_WEST, SILLY}

const FROG_TEMPLATE_PATH = "res://resources/frog_resources/%s.tres"
const FROG_LIST = ["cowboy", "gotico", "palhaco"]

func get_all_frog_templates():
	var all_frogs = []
	
	for i in FROG_LIST:
		all_frogs.append(load(FROG_TEMPLATE_PATH % i))
	
	return(all_frogs)

func get_random_frong_res(frog_res_list : Array):
	var frog_res = frog_res_list.pick_random()
	return(frog_res)
