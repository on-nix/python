import more_itertools
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

    jobs = [
        {"run": f"just build projects.{project}"}
        for project in sorted(os.listdir("projects"))
    ]

    for index, jobs_chunk in enumerate(
        more_itertools.chunked(
            jobs,
            len(jobs) // 20 + 1,
        )
    ):
        index = str(index).zfill(2)
        data["jobs"][f"build{index}"] = {
            "runs-on": "ubuntu-latest",
            "steps": [
                {"uses": "actions/checkout@v2"},
                {"uses": "cachix/install-nix-action@v13"},
                {
                    "run": "nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs"
                },
                {"run": "nix-channel --update"},
                {"run": "nix-env -i just"},
                *jobs_chunk,
            ],
        }

    with open(".github/workflows/ci.yml", "w", encoding="utf-8") as file:
        yaml.dump(data, file, indent=2, sort_keys=True)


if __name__ == "__main__":
    main()
