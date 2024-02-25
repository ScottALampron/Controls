# generate_readme.py
import openai
import subprocess
from vars import openai_api_key, readme_prompt, enable_requirements_installation, requirements_file_path

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

def generate_readme(prompt, api_key):
    # Initialize OpenAI API
    openai.api_key = api_key

    # Generate README content
    response = openai.Completion.create(
        engine="text-davinci-002",
        prompt=prompt,
        max_tokens=1000
    )

    return response.choices[0].text.strip()

def main():
    # Install requirements
    install_requirements()

    # Generate README content
    readme_content = generate_readme(readme_prompt, openai_api_key)

    # Write README content to file
    with open("README.md", "w") as f:
        f.write(readme_content)

    print("README.md file generated successfully.")

if __name__ == "__main__":
    main()
