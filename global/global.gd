extends Node

##########################################  camera strict  ############################################

onready var camera_limit_bound = Vector3(3, 0, 2)

##########################################  map editor  ############################################
onready var grand_map_manifest_data :GrandMapFileManifest
onready var grand_map_data :TileMapFileData
onready var grand_map_mission_data :GrandMapFileMission
onready var battle_map_datas :Dictionary = {} # [ Vector2:TileMapFileData ]

func empty_map_data():
	grand_map_manifest_data = GrandMapFileManifest.new()
	grand_map_manifest_data.map_name = "Ia Drang"
	grand_map_manifest_data.map_size = 2
	
	grand_map_data = TileMapUtils.generate_basic_tile_map(grand_map_manifest_data.map_size)
	
	grand_map_mission_data = GrandMapFileMission.new()
	grand_map_mission_data.bases = []
	grand_map_mission_data.points = []
	
	battle_map_datas = {}
