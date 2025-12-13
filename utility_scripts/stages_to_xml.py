import xml.etree.ElementTree as ET
from xml.dom import minidom
from lupa import LuaRuntime

def load_experience_stages(lua_path: str):
    """Reads only 'experienceStages' table from the Lua file."""
    lua = LuaRuntime(unpack_returned_tuples=True)

    with open(lua_path, "r", encoding="utf-8") as f:
        lua_code = f.read()

    # Execute file (return value is irrelevant)
    lua.execute(lua_code)

    # Now read from the Lua global environment
    globals = lua.globals()

    exp_stages = globals["experienceStages"]
    if exp_stages is None:
        raise ValueError("Lua file does not contain experienceStages variable")

    stages = []
    for i in range(1, len(exp_stages) + 1):
        entry = exp_stages[i]
        stage = {
            "minlevel": int(entry["minlevel"]),
            "multiplier": float(entry["multiplier"]),
        }
        if "maxlevel" in entry:
            stage["maxlevel"] = int(entry["maxlevel"])
        stages.append(stage)

    return stages


def generate_xml(stages, output_path: str):
    """Creates stages.xml in the requested format."""
    root = ET.Element("stages")
    ET.SubElement(root, "config", enabled="0")

    for st in stages:
        attrs = {
            "minlevel": str(st["minlevel"]),
            "multiplier": str(st["multiplier"]),
        }
        if "maxlevel" in st:
            attrs["maxlevel"] = str(st["maxlevel"])

        ET.SubElement(root, "stage", **attrs)

    # Pretty print
    xml_str = ET.tostring(root, encoding="utf-8")
    parsed = minidom.parseString(xml_str)
    pretty_xml = parsed.toprettyxml(indent="\t")

    with open(output_path, "w", encoding="utf-8") as f:
        f.write(pretty_xml)


def main():
    input_lua = "../data/stages.lua"
    output_xml = "./stages.xml"

    stages = load_experience_stages(input_lua)
    generate_xml(stages, output_xml)
    print(f"Generated XML: {output_xml}")


if __name__ == "__main__":
    main()
