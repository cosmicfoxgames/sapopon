#v0.4

class_name CommonLibrary extends Node
## Biblioteca comum dos projetos da Cosmic Fox Games

## Gera um numero aleatório[br][br]
## [param min_num] - valor mínimo a ser gerado[br]
## [param max_num] - valor máximo a ser gerado[br]
## [param is_float = false] - se sera um número decimal ou não. [param true] = decimal e [param false] = inteiro
static func get_rand_number(min_num, max_num, is_float = false):
	var rng = RandomNumberGenerator.new()
	var rand

	if is_float == true :
		rand = rng.randf_range(min_num, max_num)
	else:
		rand = rng.randi_range(min_num, max_num)

	return(rand)

## Carrega um arquivo [param .txt] externo e o transforma em uma variável [param String][br][br]
## [param file] - caminho do arquivo .txt
static func txt_to_string(file):
	var final_string = ""
	var txt = FileAccess.open(file, FileAccess.READ)
	while not txt.eof_reached():
		var line = txt.get_line()
		final_string = final_string + line + "\n"
		print(line)
	txt.close()
	return(final_string)

## Inverte uma variável [param bool], se vier [param true] volta um [param false] e vice-versa[br][br]
## [param value] - valor a ser invertido
static func invert_bool(value : bool):
	var to_return
	
	if value == true: to_return = false
	elif value == false: to_return = true
	
	return(to_return)

## Retorna verdadeiro ou falso dependendo da porcentagem de chances de algo acontecer[br][br]
## [param percentage] - porcentagem de chances de algo acontecer
static func chance_of_happening(percentage : float):
	var outcome
	var fate = get_rand_number(0, 1, true)
	
	if fate <= percentage/100:
		outcome = true
	else: outcome = false
	
	return(outcome)

## Identifica qual valor entre os valores de um Array é o maior[br][br]
## [param values] - Array com os valores a serem identificados
static func get_the_biggest_value(values : PackedInt64Array):
	var biggest = values[0]
	
	for i in values:
		if i > biggest: biggest = i
	
	return(biggest)

## Identifica se o valor é ímpar ou par[br][br]
## [param number] - número a ser identificado
static func even_or_odd(number):
	var mod = number % 2
	var to_return = true #true = even, false = odd
	
	if mod != 0: to_return = false
	
	return(to_return)

## Gera um bool aleatório[br][br]
static func coin_flip():
	var coin = get_rand_number(0, 1)
	
	match coin:
		0: return(false)
		1: return(true)
