extends CanvasLayer

@onready var EnergyStoredLabel = $MarginContainer/HBoxContainer/Inventory/Energy/Label
@onready var MatterStoredLabel = $MarginContainer/HBoxContainer/Inventory/Matter/Label
@onready var WeirdStoredLabel = $MarginContainer/HBoxContainer/Inventory/Weird/Label
@onready var CoolStoredLabel = $MarginContainer/HBoxContainer/Inventory/Cool/Label
@onready var HealthBar = $MarginContainer/HBoxContainer/ProgressBar
@onready var AmmoLabel = $MarginContainer/HBoxContainer/BoxContainer/Label
@onready var HighScoreLabel = $MarginContainer/VBoxContainer/HighScore
@onready var ScoreLabel = $MarginContainer/VBoxContainer/Score

func _ready():
	Global.connect("update_UI", update_UI)

func update_UI():
	EnergyStoredLabel.text = str(Global.energy_collected)
	MatterStoredLabel.text = str(Global.matter_collected)
	CoolStoredLabel.text = str(Global.cool_collected)
	WeirdStoredLabel.text = str(Global.weird_collected)
	HealthBar.max_value = Global.base_max_health
	HealthBar.value = Global.base_health
	AmmoLabel.text = "Ammo: " + str(Global.base_ammo) + "/" + str(Global.base_max_ammo)
	HighScoreLabel.text = "High Score: " + str(Global.high_score)
	ScoreLabel.text = "Score: " + str(Global.score)
