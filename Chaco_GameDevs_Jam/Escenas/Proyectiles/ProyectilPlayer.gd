class_name ProyectilPlayer
extends Proyectil

var nivel_proyectil:int = 0

func crear(pos: Vector2, dir: float, vel: float, nuevo_danio:float, nivel:int) -> void:
	position = pos
	rotation = dir
	velocidad = Vector2(vel, 0).rotated(dir)
	danio = nuevo_danio
	nivel_proyectil = nivel
	cambio_nivel_proyectil()

func cambio_nivel_proyectil() -> void:
	if nivel_proyectil < 4:
		var nivel = "Nivel" + str(nivel_proyectil)
		$AnimatedSprite.play(nivel)
	nivel_proyectil += 1

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_area_entered(area:Area2D)->void:
	daniar(area)

func daniar(otro_cuerpo: CollisionObject2D) -> void:
	if otro_cuerpo.has_method("recibir_danio"):
		otro_cuerpo.recibir_danio(danio)
	queue_free()

func _on_body_entered(body):
	if body is TileMap:
		return
	daniar(body)

func _on_Proyectil_body_entered(body):
	if body is TileMap:
		queue_free()

func _on_ProyectilPlayer_area_entered(area):
	daniar(area)
