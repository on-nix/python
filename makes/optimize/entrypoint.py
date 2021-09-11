import json
import os
from typing import (
    Any,
)


def load_json(path: str) -> Any:
    with open(path) as file:
        return json.load(file)


def write_json(path, data: Any) -> None:
    with open(path, "w") as file:
        json.dump(data, file, indent=2, sort_keys=True)


def main() -> None:
    for project in sorted(os.listdir("projects")):
        print(project)
        project_path = os.path.join("projects", project)
        for version in sorted(os.listdir(project_path)):
            version_path = os.path.join(project_path, version)
            if os.path.isdir(version_path):
                py_common_path = os.path.join(version_path, "python3*.json")
                py_common = (
                    set(load_json(py_common_path).items())
                    if os.path.exists(py_common_path)
                    else set()
                )

                py = {
                    py_version: set(load_json(py_path).items()) | py_common
                    for py_version in ["36", "37", "38", "39"]
                    for py_path in [
                        os.path.join(
                            version_path,
                            f"python{py_version}.json",
                        )
                    ]
                    if os.path.exists(py_path)
                }

                if not py:
                    continue

                py_common = set.intersection(*py.values())
                py_common_ = dict(py_common)
                py_common_.pop(project, None)

                write_json(py_common_path, py_common_)

                for py_version in py:
                    py[py_version] = dict(py[py_version] - py_common)
                    py[py_version].pop(project, None)
                    write_json(
                        os.path.join(version_path, f"python{py_version}.json"),
                        py[py_version],
                    )


if __name__ == "__main__":
    main()
