class_name Proyectil
extends Area2D

var velocidad:Vector2 = Vector2.ZERO
var danio:float = 2.0

func _physics_process(delta: float) -> void :
	position += velocidad * delta

func crear(pos: Vector2, dir: float, vel: float, nuevo_danio:float, nivel:int) -> void:
	position = pos
	rotation = dir
	velocidad = Vector2(vel, 0).rotated(dir)
	danio = nuevo_danio

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_area_entered(area:Area2D)->void:
	daniar(area)

func daniar(otro_cuerpo) -> void:
	if otro_cuerpo.has_method("recibir_danio"):
		otro_cuerpo.recibir_danio(danio)
	queue_free()

func _on_body_entered(body: Node):
	daniar(body)
