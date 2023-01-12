extends Timer

export var tiempo_entre_enemigos:Vector2 = Vector2()
export var enemigo:PackedScene = null
export var enemigos_totales:int = 5
export var tiempo_inicio:float = 1.5

onready var zona_spawn:ReferenceRect = $ZonaSpawn
onready var random = RandomNumberGenerator.new()

func _ready() -> void:
	self.wait_time = tiempo_inicio
	random.randomize()

func _on_Oleada_timeout() -> void:
	if enemigos_totales > 0:
		self.wait_time = random.randf_range(tiempo_entre_enemigos.y, tiempo_entre_enemigos.x)
		var posicion = Vector2(randf() * zona_spawn.rect_size.x, randf() * zona_spawn.rect_size.y)
		var new_enemigo = enemigo.instance()
		new_enemigo.crear(posicion)
		Eventos.emit_signal("instanciar_enemigo", new_enemigo)
	enemigos_totales -= 1
