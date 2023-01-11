extends Control

export var escena_juego = 'res://Escenas/Niveles/Nivel.tscn'

onready var continuar_button = $MarginContainer/VBoxContainer2/VBoxContainer/Continuar
var continuar = ''
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if continuar == '':
		continuar_button.disabled = true
	else: 
		continuar_button.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Jugar_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(escena_juego) # Replace with function body.


func _on_Continuar_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene(continuar)


func _on_Salir_pressed():
	get_tree().quit()
