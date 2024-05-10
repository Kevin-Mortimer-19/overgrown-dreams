class_name GameData extends Resource

@export var MarsData: CharacterData
@export var MedeaData: CharacterData
@export var HeinrichData: CharacterData

@export var file_name: String = "user://save.tres"

func save_game():
	var s = ResourceSaver.save(self, file_name, ResourceSaver.FLAG_BUNDLE_RESOURCES)


# Probably doesn't work
func load_game():
	if ResourceLoader.exists(file_name):
		return ResourceLoader.load(file_name)
		
