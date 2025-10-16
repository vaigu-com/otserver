import xml.etree.ElementTree as ET

# Load rare monster names into a set
with open("./utility_scripts/rare_monster_name.txt", "r", encoding="utf-8") as f:
    rare_monsters = {line.strip() for line in f if line.strip()}

# Parse the XML file
tree = ET.parse("./data-vaigu/world/vaigu-monster.xml")
root = tree.getroot()

# Loop through all monster tags
for monster in root.findall(".//monster"):
    name = monster.get("name")
    if not name:
        continue

    if name in rare_monsters:
        monster.set("spawntime", "3600")  # Rare monsters
    else:
        monster.set("spawntime", "90")    # Normal monsters

# Save updated XML
tree.write("./data-vaigu/world/vaigu-monster.xml", encoding="utf-8", xml_declaration=True)

print("✅ XML was updated!")
