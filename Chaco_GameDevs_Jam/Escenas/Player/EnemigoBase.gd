class_name EnemigoBase
extends Area2D

onready var player_objetivo = null

export var danio:float = 2.0
export var velocidad:int = 200
var moviendose:bool = true

var movimiento:Vector2 = Vector2.ZERO

func _ready() -> void:
	player_objetivo = DatosJuego.player_actual

func _process(delta) -> void:
	if player_objetivo != null:
		movimiento = global_position.direction_to(player_objetivo.global_position)
	global_position += movimiento * velocidad * delta


func _on_EnemigoBase_body_entered(body):
	if body.has_method("recibir_danio"):
		body.recibir_danio(danio)
		#borrar test
		print("hice danio")

func _on_EnemigoBase_body_exited(body):
	pass # Replace with function body.
