class_name HUD
extends CanvasLayer

## VIDA
onready var vidaMax = $Vida/VidaContainer/ProgressBar/Letras/VidaMax
onready var barVidaMax = $Vida/VidaContainer/ProgressBar
onready var vidaActual = $Vida/VidaContainer/ProgressBar/Letras/VidaActual
onready var barVidaActual = $Vida/VidaContainer/ProgressBar

## ENEMIGOS
onready var enemigosRestantes = $Enemigos/EnemigosContainer/ProgressBar/Enemigos
onready var barEnemigosRestantes = $Enemigos/EnemigosContainer/ProgressBar
onready var barEnemigosTotales = $Enemigos/EnemigosContainer/ProgressBar

##RONDAS 
onready var labelRondas = $Rondas

func _ready():
	visible = true
# warning-ignore:return_value_discarded
	Eventos.connect("cambio_vida", self,"on_cambio_vida")
# warning-ignore:return_value_discarded
	Eventos.connect("comenzar_oleada", self, "on_comenzar_oleada")
# warning-ignore:return_value_discarded
	Eventos.connect("enemigos_totales", self, "on_enemigos_totales")

func on_cambio_vida(vida:int) -> void:
	set_vida_actual(vida)

func on_enemigos_totales(enemigos:int) -> void:
	set_enemigos_totales(enemigos)

func on_comenzar_oleada(numero_oleada:int) -> void:
	set_ronda(numero_oleada)

func set_vida_maxima(vidaMaxima):
	vidaMax.text = str(vidaMaxima)
	barVidaMax.set_max(vidaMaxima) 

func set_vida_actual(vidaAct):
	vidaActual.text = str(vidaAct)
	barVidaActual.value = vidaAct 

func descontar_enemigos():
	enemigosRestantes.text = str(barEnemigosRestantes.value - 1)
	barEnemigosRestantes.value = barEnemigosRestantes.value - 1

func set_enemigos_restantes(enemigos):
	enemigosRestantes.set_text(str(enemigos))
	barEnemigosRestantes.set_value(enemigos)

func set_enemigos_totales(enemigos:int):
	print('Se establecieron los nuevos totales')
	barEnemigosTotales.set_value(enemigos)
	barEnemigosTotales.set_max(enemigos)
	enemigosRestantes.set_text(str(enemigos))
		

func set_ronda(n:int):
	labelRondas.text = str(n)
