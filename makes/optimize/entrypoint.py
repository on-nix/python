import json
import os
from typing import (
    Dict,
)


def load_json(path) -> Dict[str, str]:
    with open(path) as file:
        return json.load(file)


def main() -> None:
    for project in sorted(os.listdir("projects")):
        project_path = os.path.join("projects", project)
        for version in sorted(os.listdir(project_path)):
            version_path = os.path.join(project_path, version)
            if os.path.isdir(version_path):
                closure36 = load_json(
                    os.path.join(version_path, "python36.json")
                )
                closure38 = load_json(
                    os.path.join(version_path, "python36.json")
                )
                closure39 = load_json(
                    os.path.join(version_path, "python36.json")
                )
                closure40 = load_json(
                    os.path.join(version_path, "python36.json")
                )


if __name__ == "__main__":
    main()
