class_name Oleada
extends Timer

export var enemigoRata:PackedScene = null
export var enemigoMurcielago:PackedScene = null
export var enemigoFantasma:PackedScene = null
export var enemigoArana:PackedScene = null
export var enemigoCactus:PackedScene = null
export var enemigoCiclope:PackedScene = null

export var tiempo_entre_enemigos_1:Vector2 = Vector2()
export var tiempo_entre_enemigos_2:Vector2 = Vector2()
export var enemigos_totales_1:int = 5
export var enemigos_totales_2:int = 5
export var tiempo_inicio:float = 1.5

onready var zona_spawn:ReferenceRect = $ZonaSpawn
onready var random = RandomNumberGenerator.new()
 
var enemigo_1:int
var enemigo_2:int

var enemigos:Array = []

func _ready() -> void:
	self.wait_time = tiempo_inicio
	random.randomize()
	enemigos.append(enemigoRata)
	enemigos.append(enemigoMurcielago)
	enemigos.append(enemigoFantasma)

func _on_Oleada_timeout() -> void:
	if enemigos_totales_1 > 0:
		self.wait_time = random.randf_range(tiempo_entre_enemigos_1.y, tiempo_entre_enemigos_1.x)
		var posicion = Vector2(randf() * zona_spawn.rect_size.x, randf() * zona_spawn.rect_size.y)
		if enemigo_1 >= 0 && enemigo_1 <= 5:
			var enemigo = enemigos[1]
			print(enemigo)
			var new_enemigo = enemigo.instance()
			new_enemigo.crear(posicion)
			Eventos.emit_signal("instanciar_enemigo", new_enemigo)
	enemigos_totales_1 -= 1

func configurarOleada(tiempo_enemigos_1:Vector2, enemigo1:int, enemigos_tot_1:int, tiempo_enemigos_2:Vector2, enemigo2:int, enemigos_tot_2:int,tiempoInicio:float) -> void:
	tiempo_entre_enemigos_1 = tiempo_enemigos_1
	tiempo_entre_enemigos_2 = tiempo_enemigos_2
	enemigos_totales_1 = enemigos_tot_1
	enemigos_totales_2 = enemigos_tot_2
	enemigo_1 = enemigo1
	enemigo_2 = enemigo2
	self.wait_time = tiempoInicio
	self.start()
	$Enemigo2.wait_time = tiempoInicio
	$Enemigo2.start()

func _on_Enemigo2_timeout():
	if enemigo_2 >= 0 && enemigo_2 <= 5:
		self.wait_time = random.randf_range(tiempo_entre_enemigos_2.y, tiempo_entre_enemigos_2.x)
		var posicion = Vector2(randf() * zona_spawn.rect_size.x, randf() * zona_spawn.rect_size.y)
		if enemigo_2 != 0:
			var enemigo = enemigos[enemigo_2]
			var new_enemigo = enemigo.instance()
			new_enemigo.crear(posicion)
			Eventos.emit_signal("instanciar_enemigo", new_enemigo)
	enemigos_totales_2 -= 1
