extends Resource

class_name CommandRequirement

enum RequirementType { Nutrition, DNA, Adjacency }

@export var type: RequirementType
@export var value: int
@export var tag: String

func evaluate():
  match type:
    RequirementType.Nutrition:
      return Stats.nutrition >= value
    RequirementType.DNA:
      return Stats.dna >= value
    RequirementType.Adjacency:
      return TileManager.is_adjacent_to_tiles(Globals.last_selected_pos, value, tag)
