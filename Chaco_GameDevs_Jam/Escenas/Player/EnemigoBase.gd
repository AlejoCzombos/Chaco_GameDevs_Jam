class_name EnemigoBase
extends Area2D

onready var player_objetivo = null
onready var tiempoStun:Timer = $TiempoStun

export var vida:float = 5.0
export var danio:float = 2.0
export var velocidad:int = 200

var stuneado:bool = false
var moviendose:bool = true
var movimiento:Vector2 = Vector2.ZERO

func _ready() -> void:
	player_objetivo = DatosJuego.player_actual

func _process(delta) -> void:
	if player_objetivo != null && !stuneado:
		movimiento = global_position.direction_to(player_objetivo.global_position)
	elif stuneado:
		movimiento = lerp(movimiento, Vector2(0,0), 0.3)
	global_position += movimiento * velocidad * delta

func recibir_danio(danioo:float) -> void:
	if vida > 0:
		vida -= danioo
	else:
		queue_free()

func _on_EnemigoBase_body_entered(body):
	if body.has_method("recibir_danio"):
		body.recibir_danio(danio)
		movimiento = -movimiento * 4
		#borrar test
		print("hice danio")

func _on_area_entered(area):
	if area is Proyectil:
		stuneado = true
		movimiento = -movimiento * 3
		tiempoStun.start()
		modulate = Color.red


func _on_TiempoStun_timeout():
	modulate = Color.white
	stuneado = false
