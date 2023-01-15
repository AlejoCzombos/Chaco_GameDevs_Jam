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

onready var seleccionar_mejora = $Mejora

func _ready():
	visible = true
# warning-ignore:return_value_discarded
	Eventos.connect("cambio_vida", self,"on_cambio_vida")
# warning-ignore:return_value_discarded
	Eventos.connect("comenzar_oleada", self, "on_comenzar_oleada")
# warning-ignore:return_value_discarded
	Eventos.connect("enemigos_totales", self, "on_enemigos_totales")
# warning-ignore:return_value_discarded
	Eventos.connect("danio_jugador", self, "danio")
# warning-ignore:return_value_discarded
	Eventos.connect("oleada_terminada", self, "on_oleada_terminada")
# warning-ignore:return_value_discarded
	Eventos.connect("mejoraSeleccionada", self, "on_mejora_seleccionada")
# warning-ignore:return_value_discarded
	Eventos.connect("subidaVida", self, "on_subida_vida")

func on_mejora_seleccionada(_mejora:int) -> void:
	#TODO: animacion esconder
	get_tree().paused = false
	seleccionar_mejora.visible = false
	Eventos.emit_signal("comenzar_oleada", DatosJuego.oleada_actual)
	pass

func on_subida_vida(vidaMax) -> void:
	set_vida_maxima(vidaMax)
	set_vida_actual(vidaMax)

func on_oleada_terminada() -> void:
	seleccionar_mejora.definir_cartas()
	seleccionar_mejora.visible = true
	get_tree().paused = true

func on_cambio_vida(vida:int) -> void:
	set_vida_actual(vida)

func on_enemigos_totales(enemigos:int) -> void:
	set_enemigos_totales(enemigos)

func on_comenzar_oleada(numero_oleada:int) -> void:
	get_tree().paused = false
	set_ronda(numero_oleada)

func set_vida_maxima(vidaMaxima):
	vidaMax.text = str(vidaMaxima)
	barVidaMax.max_value = vidaMaxima 

func set_vida_actual(vidaAct):
	vidaActual.text = str(vidaAct)
	barVidaActual.value = vidaAct 

func descontar_enemigos():
	enemigosRestantes.text = str(barEnemigosRestantes.value - 1)
	barEnemigosRestantes.value = barEnemigosRestantes.value - 1

func set_enemigos_restantes(enemigos):
	enemigosRestantes.text = str(enemigos)
	barEnemigosRestantes.value = enemigos

func set_enemigos_totales(enemigos:int):
	barEnemigosTotales.max_value = enemigos
	enemigosRestantes.text = str(barEnemigosTotales.max_value)
	barEnemigosTotales.value = barEnemigosTotales.max_value

func set_ronda(n:int):
	labelRondas.text = str(n)

func danio():
	$AnimationPlayer.play("Danio")
