class_name HeroActor extends Actor

var skills: Skillset

func _init(st: Stats, sk: Skillset):
	skills = sk
	super(st)
