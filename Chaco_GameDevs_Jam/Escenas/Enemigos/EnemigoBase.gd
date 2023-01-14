class_name EnemigoBase
extends KinematicBody2D

enum ESTADO {SPAWN, VIVO, MUERTO}

onready var player_objetivo = null
onready var tiempoStun:Timer = $TiempoStun
onready var colisionador:CollisionShape2D = $CollisionShape2D
onready var colisionadorArea:CollisionShape2D = $Hitbox/CollisionShape2D
onready var hitSFX:AudioStreamPlayer = $Hit

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
	move_and_slide(movimiento * (velocidad * 100) * delta)

func controladorEstado(nuevoEstado: int) -> void:
	match nuevoEstado:
		ESTADO.SPAWN:
			colisionador.set_deferred("disabled", true)
			colisionadorArea.set_deferred("disabled", true)
		ESTADO.VIVO:
			puede_moverse = true
			colisionador.set_deferred("disabled", false)
			colisionadorArea.set_deferred("disabled", false)
		ESTADO.MUERTO:
			Eventos.emit_signal("descontar_enemigo")
			puede_moverse = false
			colisionador.set_deferred("disabled", true)
			colisionadorArea.set_deferred("disabled", true)
			queue_free()
		_:
			printerr("Error estados")
	estadoActual = nuevoEstado

func recibir_danio(danioo:float) -> void:
	if estadoActual == ESTADO.VIVO:
		hitSFX.play()
		stuneado = true
		movimiento = -movimiento * 4
		tiempoStun.start()
		modulate = Color.red
		if danioo >= vida:
			disparar()
			yield(get_tree().create_timer(0.06), "timeout")
			controladorEstado(ESTADO.MUERTO)
		if vida > 0:
			vida -= danioo

func disparar() -> void:
	pass

func crear(pos:Vector2) -> void:
	position = pos

func _on_TiempoStun_timeout():
	modulate = Color.white
	stuneado = false

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Spawn":
		controladorEstado(ESTADO.VIVO)
		$AnimationPlayer.play("Correr")

func _on_body_entered(body):
	if body.has_method("recibir_danio") && body is Player:
		body.recibir_danio(danio)
