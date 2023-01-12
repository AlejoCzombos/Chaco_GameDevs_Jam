class_name EnemigoBase
extends Area2D

enum ESTADO {SPAWN, VIVO, MUERTO}

onready var player_objetivo = null
onready var tiempoStun:Timer = $TiempoStun
onready var colisionador:CollisionShape2D = $CollisionShape2D

export var vida:float = 5.0
export var danio:float = 2.0
export var velocidad:int = 200

var estadoActual:int = ESTADO.SPAWN
var stuneado:bool = false
var puede_moverse:bool = false
var movimiento:Vector2 = Vector2.ZERO

func _ready() -> void:
	player_objetivo = DatosJuego.player_actual

func _process(delta) -> void:
	if player_objetivo != null && !stuneado && puede_moverse:
		movimiento = global_position.direction_to(player_objetivo.global_position)
	elif stuneado:
		movimiento = lerp(movimiento, Vector2(0,0), 0.3)
	global_position += movimiento * velocidad * delta

func controladorEstado(nuevoEstado: int) -> void:
	match nuevoEstado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disabled", true)
		ESTADO.VIVO:
			puede_moverse = true
			colisionador.set_deferred("disabled", false)
		ESTADO.MUERTO:
			puede_moverse = false
			colisionador.set_deferred("disabled", true)
			queue_free()
		_:
			printerr("Error estados")
	estadoActual = nuevoEstado

func recibir_danio(danioo:float) -> void:
	if estadoActual == ESTADO.VIVO:
		if vida > 0:
			vida -= danioo
		else:
			controladorEstado(ESTADO.MUERTO)

func _on_EnemigoBase_body_entered(body):
	if body.has_method("recibir_danio"):
		body.recibir_danio(danio)
		#borrar test
		print("hice danio")

func _on_area_entered(area):
	if area is Proyectil:
		stuneado = true
		movimiento = -movimiento * 4
		tiempoStun.start()
		modulate = Color.red

func crear(pos:Vector2) -> void:
	position = pos

func _on_TiempoStun_timeout():
	modulate = Color.white
	stuneado = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Spawn":
		controladorEstado(ESTADO.VIVO)
		$AnimationPlayer.play("Correr")
