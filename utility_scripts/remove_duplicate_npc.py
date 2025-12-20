import os

# list of reference folders (files here are "protected")
reference_folders = [
    r"data-vaigu\npc",
    r"data-vaigu\npc\old_system",
    r"data-vaigu\npc\shop_only",
    r"data-vaigu\npc\warzone",
]

# folder to trim
target_folder = r"data-vaigu\npc\real"
# collect all file names from reference folders
reference_files = set()
for folder in reference_folders:
    if os.path.exists(folder):
        reference_files.update(os.listdir(folder))

# get file names in B
files_B = set(os.listdir(target_folder))

# find overlap
common_files = reference_files & files_B

# delete matches from B
for file in common_files:
    file_path = os.path.join(target_folder, file)
    try:
        if os.path.isfile(file_path):
            os.remove(file_path)
            print(f"Removed: {file_path}")
        elif os.path.isdir(file_path):
            # optional: remove directories if needed
            # import shutil
            # shutil.rmtree(file_path)
            print(f"Skipped directory: {file_path}")
    except Exception as e:
        print(f"Error deleting {file_path}: {e}")

print("Trim complete.")
