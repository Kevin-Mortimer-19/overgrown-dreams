class_name GameData extends Resource

@export var MarsData: Resource
@export var MedeaData: Resource
@export var HeinrichData: Resource

@export var file_name: String

func save():
	var s = ResourceSaver.save(self, file_name, ResourceSaver.FLAG_BUNDLE_RESOURCES)
