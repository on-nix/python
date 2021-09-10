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
        "jobs": {
            "build": {
                "env": {
                    "CACHIX_AUTH_TOKEN": "${{ secrets.CACHIX_AUTH_TOKEN }}"
                },
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
            },
        },
    }

    for project in sorted(os.listdir("projects")):
        project_path = os.path.join("projects", project)
        data["jobs"]["build"]["steps"].append(
            {"run": f"just build projects.{project}"}
        )

    data["jobs"]["build"]["steps"].append({"run": "just build projects"})

    with open(".github/workflows/ci.yml", "w") as file:
        yaml.dump(data, file, indent=2, sort_keys=True)


if __name__ == "__main__":
    main()
