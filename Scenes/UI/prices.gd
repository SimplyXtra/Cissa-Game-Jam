extends Control

@onready var EnergyLabel = $ItemCost/EnergyCost/Label
@onready var MatterLabel = $ItemCost/MatterCost/Label
@onready var WeirdLabel = $ItemCost/WeirdCost/Label
@onready var CoolLabel = $ItemCost/CoolCost/Label

func set_prices(energy:int = 0, matter:int = 0, weird:int = 0, cool:int = 0):
	EnergyLabel.text = str(energy)
	MatterLabel.text = str(matter)
	WeirdLabel.text = str(weird)
	CoolLabel.text = str(cool)
