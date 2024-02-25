extends Node2D
var enemies := [preload("res://Scenes/Enemies/red_enemy.tscn"), preload("res://Scenes/Enemies/green_enemy.tscn"), preload("res://Scenes/Enemies/blue_enemy.tscn")]
var enemySpawnProbabilities := [85, 100, 100]
var enemySpawned:CharacterBody2D
var enemySpawnLocations := []
var spawnInterval:float = 1
var minSpawnInterval:float = 1.0
var maxSpawnInterval:float = 4.0

var item_drops := [preload("res://Scenes/Items/cool.tscn"), preload("res://Scenes/Items/energy.tscn"), preload("res://Scenes/Items/matter.tscn"), preload("res://Scenes/Items/weird.tscn")]

func _ready()  -> void:
	enemySpawnLocations = $EnemySpawnLocations.get_children()

func enemySpawn() -> void:
	var spawnLocation:int = randi()%4
	var randomEnemy:int = randi()%100
	if randomEnemy < enemySpawnProbabilities[0]:
		enemySpawned = enemies[0].instantiate()
	elif randomEnemy < enemySpawnProbabilities[1]:
		enemySpawned = enemies[1].instantiate()
	else:
		enemySpawned = enemies[2].instantiate()
	enemySpawned.position = enemySpawnLocations[spawnLocation].global_position
	enemySpawned.spawnLocation = spawnLocation
	enemySpawned.connect("dropItem", dropRandomItem)
	$Enemies.add_child(enemySpawned)

func dropRandomItem(location) -> void:
	var drop = item_drops[randi()%4].instantiate()
	drop.position = location
	$Items.call_deferred("add_child",drop)

func _on_enemy_spawn_timer_timeout():
	enemySpawn()
	spawnInterval = randf_range(minSpawnInterval, maxSpawnInterval)
	$EnemySpawnTimer.wait_time = spawnInterval
	$EnemySpawnTimer.start()


func _on_audio_stream_player_finished():
	$Audio/AudioStreamPlayer.play()
