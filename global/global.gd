extends Node

signal map_loaded
signal map_saved

func _ready():
	_init_save_load_map()
	
##########################################  camera strict  ############################################

onready var camera_limit_bound = Vector3(3, 0, 2)

##########################################  map editor  ############################################
# for load and save maps
const map_dir = "map"
var save_load_map :SaveLoadImproved

onready var grand_map_manifest_datas :Array = [] # [ GrandMapFileManifest ]

func _init_save_load_map():
	save_load_map = preload("res://addons/save_load/save_load_improve.tscn").instance()
	add_child(save_load_map)

func load_maps() :
	grand_map_manifest_datas.clear()
	var list :PoolStringArray = Utils.get_all_resources("user://%s/" % map_dir, ["manifest"])
	for i in list:
		var m :GrandMapFileManifest = GrandMapFileManifest.new()
		var data = SaveLoad.load_save(i,false)
		m.from_dictionary(data)
		grand_map_manifest_datas.append(m)
		
func save_map(filename :String, data, use_prefix = true):
	var path = "%s/%s" %[map_dir, filename] if use_prefix else filename
	save_load_map.save_data_async(path, data, use_prefix)
	
# for editor
onready var grand_map_manifest_data :GrandMapFileManifest
onready var grand_map_data :TileMapFileData
onready var grand_map_mission_data :GrandMapFileMission
onready var battle_map_datas :Dictionary = {} # [ Vector2:TileMapFileData ]

func empty_map_data():
	grand_map_manifest_data = GrandMapFileManifest.new()
	grand_map_manifest_data.map_name = RandomNameGenerator.generate_name()
	grand_map_manifest_data.map_size = 2
	
	grand_map_data = TileMapUtils.generate_basic_tile_map(grand_map_manifest_data.map_size)
	
	grand_map_mission_data = GrandMapFileMission.new()
	grand_map_mission_data.bases = []
	grand_map_mission_data.points = []
	
	battle_map_datas = {}
	
##########################################  util  ############################################
func save_ss(map_name:String) -> String:
	var img: Image = get_viewport().get_texture().get_data()
	img.flip_y()
	
	var w = img.get_width()
	var h = img.get_height()
	var crop_rect = Rect2((w - 512)/2, (h - 512)/2, 512, 512)
	var img_path = "user://%s/%s.png" % [map_dir, map_name]
	var cropped_img = Image.new()
	cropped_img.create(512, 512, false, img.get_format())
	cropped_img.blit_rect(img, crop_rect, Vector2(0,0))
	cropped_img.save_png(img_path)
	yield(get_tree(),"idle_frame")
	
	return img_path
