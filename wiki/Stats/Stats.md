## Base Stats

[[Strength]] (melee damage, carry capacity, physical damage resistance)
[[Dexterity]] (gun damage, movement speed, dodge chance)
[[Attunement]] (spell damage, radar radius, spell resistance)
[[Vitality]] (max health, max stamina)
[[Energy]] (max mana, stamina regeneration)
[[Health]]
[[Mana]]

## Derived Stats

Max Health: (5 * Vitality) + (10 * Health)
Max Mana: (5 * Energy) + (10 * Mana)
Max Stamina: (10 * Vitality)
Stamina Regeneration: (3 * Energy)

Physical Damage Resistance: (Strength / 3) % resistance
Spell Resistance: (Attunement / 4) % resistance
Dodge Chance: 1 - ( 1 / sqrt( ( Dexterity + 100 ) / 100 ) ) % chance

Carry Capacity: (50 * (1.1 ^ Strength) ) + (5 * Strength)
Movement Speed: class speed * weapon speed * (1.01 ^ Dexterity)
Radar Radius: base radius * (1.05 ^ Attunement)

Melee Damage: Weapon Base Damage + (Strength / 2)
Gun Damage: Weapon Base Damage * (1 + (Dexterity / 100) )
Spell Damage: Spell Base Power * (1.01 ^ Attunement)
