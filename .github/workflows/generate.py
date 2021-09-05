import os
import yaml


def main() -> None:
    data = {
        "concurrency": {
            "cancel-in-progress": True,
            "group": "${{ github.actor }}",
        },
        "name": "ci",
        "on": ["pull_request", "push"],
        "jobs": {},
    }

    closures = {
        "python36": "python3.6.json",
        "python37": "python3.7.json",
        "python38": "python3.8.json",
        "python39": "python3.9.json",
    }
    for python in closures:
        data["jobs"][python] = {
            "env": {"CACHIX_AUTH_TOKEN": "${{ secrets.CACHIX_AUTH_TOKEN }}"},
            "runs-on": "ubuntu-latest",
            "steps": [
                {"uses": "actions/checkout@v2"},
                {"uses": "cachix/install-nix-action@v13"},
                {
                    "run": "nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs"
                },
                {"run": "nix-channel --update"},
                {"run": "nix-env -i cachix"},
                {"run": "nix-env -i just"},
            ],
        }
        for project in sorted(os.listdir("projects")):
            project_path = os.path.join("projects", project)
            for version in sorted(os.listdir(project_path)):
                version_path = os.path.join(project_path, version)
                if os.path.isdir(version_path) and os.path.exists(
                    os.path.join(version_path, closures[python])
                ):
                    data["jobs"][python]["steps"].append(
                        {
                            "run": f"just build '{python}.\"{project}-{version}\"'",
                        }
                    )

    with open(".github/workflows/ci.yml", "w") as file:
        yaml.dump(data, file, indent=2, sort_keys=True)


if __name__ == "__main__":
    main()
