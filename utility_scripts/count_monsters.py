import xml.etree.ElementTree as ET
from collections import Counter
import os

# Path to your large XML file
xml_file = "../data-vaigu/world/vaigu-monster.xml"
#xml_file = "../data-vaigu/world/custom/realmap-monster.xml"

# Output file will have the same name but with "_counts.txt"
base, _ = os.path.splitext(xml_file)
output_file = f"./monster_counts.txt"

# Create a counter for monster names
monster_counts = Counter()

# Incremental parsing for large files
for event, elem in ET.iterparse(xml_file, events=("end",)):
    if elem.tag == "monster" and "name" in elem.attrib:
        name = elem.attrib["name"]
        monster_counts[name] += 1
    elem.clear()

# Save results to file
with open(output_file, "w", encoding="utf-8") as f:
    for name, count in sorted(monster_counts.items(), key=lambda x: (-x[1], x[0])):
        f.write(f"{name}: {count}\n")

print(f"✅ Monster counts saved to: {output_file}")
