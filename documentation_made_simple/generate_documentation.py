# generate_documentation.py
import os
import subprocess
from github import Github
from vars import *

def install_requirements():
    if enable_requirements_installation:
        try:
            with open(requirements_file_path, 'r') as f:
                requirements = f.readlines()
                requirements = [req.strip() for req in requirements]

            print("Checking and installing required libraries...")
            for req in requirements:
                subprocess.check_call(["pip", "install", req])
        except FileNotFoundError:
            print(f"Requirements file '{requirements_file_path}' not found.")
    else:
        print("Requirements installation is disabled.")

def get_repository_files(repo):
    files = []
    contents = repo.get_contents("")
    while contents:
        file_content = contents.pop(0)
        if file_content.type == "file":
            files.append(file_content)
        elif file_content.type == "dir":
            contents.extend(repo.get_contents(file_content.path))
    return files

def generate_documentation(github_owner, github_repo):
    # Authenticate with GitHub
    g = Github()

    # Get repository
    repo = g.get_repo(f"{github_owner}/{github_repo}")

    # Install requirements
    install_requirements()

    # Create markdown content
    markdown_content = f"# {github_repo}\n\n"

    # Add repository description
    markdown_content += f"**Description:** {repo.description}\n\n"

    # Add repository URL
    markdown_content += f"**Repository URL:** [{repo.full_name}]({repo.html_url})\n\n"

    # Add introduction
    markdown_content += "## Introduction\n\n"
    markdown_content += "Provide a brief introduction to your project here.\n\n"

    # Add features
    markdown_content += "## Features\n\n"
    markdown_content += "List the key features of your project here.\n\n"

    # Add installation
    markdown_content += "## Installation\n\n"
    markdown_content += "Provide instructions on how to install your project here.\n\n"

    # Add usage
    markdown_content += "## Usage\n\n"
    markdown_content += "Provide usage examples and instructions here.\n\n"

    # Add contributing
    markdown_content += "## Contributing\n\n"
    markdown_content += "Provide guidelines for contributing to your project here.\n\n"

    # Add files
    markdown_content += "## Files\n\n"
    files = get_repository_files(repo)
    for file in files:
        markdown_content += f"- [{file.name}]({file.html_url})\n"

    # Write markdown content to file
    with open("README.md", "w") as f:
        f.write(markdown_content)

def main():
    generate_documentation(github_owner, github_repo)

if __name__ == "__main__":
    main()
