extends Control

onready var mago1 = preload("res://Escenas/Player/magoLvl1.png") 
onready var mago2 = preload("res://Escenas/Player/magoLvl2.png")
onready var mago3 = preload("res://Escenas/Player/magoLvl3.png")
onready var mago4 = preload("res://Escenas/Player/magoLvl4.png")
onready var mago5 = preload("res://Escenas/Player/magoLvl5.png")
onready var textura_mago = $Paper/HBoxContainer/TextureRect

onready var stats_poder = $Paper/HBoxContainer/Stats/Poder
onready var stats_ratio = $Paper/HBoxContainer/Stats/Ratio
onready var stats_vida = $Paper/HBoxContainer/Stats/Vida
onready var stats_velocidad = $Paper/HBoxContainer/Stats/Velocidad

# esto es para cargar las estadisticas
#onready var player_poder = $Paper/HBoxContainer/Stats/Poder
#onready var player_ratio = $Paper/HBoxContainer/Stats/Ratio
#onready var player_vida = $Paper/HBoxContainer/Stats/Vida
#onready var plsyer_velocidad = $Paper/HBoxContainer/Stats/Velocidad

export(String, FILE, "*.tscn") var menu_principal = ""

func _ready(): 
	visible = false
	actualizarStats()
	actualizarImgNivelMago()

func actualizarStats():
	## Esto es para actualizar los stats al poner pausa
	## Hay que ponerle las stats correctas
	stats_poder.text = '1'
	stats_ratio.text = '1'
	stats_vida.text = '00'
	stats_velocidad.text = '00'

func actualizarImgNivelMago():
	textura_mago.texture = mago3

func _on_MenuPrincipal_pressed():
	# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_principal)
	get_tree().paused = false

func _on_Continuar_pressed():
	get_tree().paused = false
	visible = false

func _input(event):
	if event.is_action_pressed("Pausa"):
		visible = !visible
		get_tree().paused = !get_tree().paused
