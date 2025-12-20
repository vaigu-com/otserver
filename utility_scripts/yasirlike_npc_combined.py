import os

# --- Configuration ---
root_dir = r"../data-vaigu/npc/"   # change this to your root directory
output_file = r"./yasirlike_npc_raw.lua"

# --- List of names ---
names = [
    "A_Fluffy_Squirrel", "Angus", "Baltim", "Baxter", "Alaistar", "Arkulius", "Asnarus", "Augustin",
    "Brengus", "Buddel", "Chip", "Cruleo", "Elane", "Esrik", "Fadil", "Fiona", "Gladys", "Gnomission",
    "Grizzly_Adams", "Hjaern", "Humgolf", "Inigo", "Irmana", "Julius", "Legola", "Luna", "Malunga",
    "Melfar", "Mortimer", "Mugruu", "Partos", "Pompan", "Ramina", "Rock_in_a_Hard_Place", "Swolt",
    "Talila", "Tarun", "Telas", "The_Librarian", "Todd", "Tom", "Tothdral", "Ustan", "Valindara",
    "Yasir", "Zaidal"
]

# --- Prepare lowercase .lua filenames ---
target_filenames = {f"{name.lower()}.lua" for name in names}

# --- Iterate recursively and collect matches ---
found_files = []

for dirpath, dirnames, filenames in os.walk(root_dir):
    for fname in filenames:
        if fname.lower() in target_filenames:
            found_files.append(os.path.join(dirpath, fname))

# --- Combine contents ---
with open(output_file, "w", encoding="utf-8") as out_f:
    for fpath in found_files:
        try:
            with open(fpath, "r", encoding="utf-8") as in_f:
                content = in_f.read()
            out_f.write(f"-- Start of {os.path.basename(fpath)} --\n")
            out_f.write(content)
            out_f.write(f"\n-- End of {os.path.basename(fpath)} --\n\n")
        except Exception as e:
            print(f"Skipping {fpath}: {e}")

print(f"Combined {len(found_files)} files into {output_file}")

#^((?!clientId = ).)*$
#^((?!\{ ).)*$
#\n\n