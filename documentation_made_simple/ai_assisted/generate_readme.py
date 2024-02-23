# generate_readme.py

import openai
from vars import openai_api_key, readme_prompt

def generate_readme(prompt, api_key):
    # Initialize OpenAI API
    openai.api_key = api_key

    # Generate README content
    response = openai.Completion.create(
        engine="davinci-codex",
        prompt=prompt,
        max_tokens=1000
    )

    return response.choices[0].text.strip()

def main():
    # Generate README content
    readme_content = generate_readme(readme_prompt, openai_api_key)

    # Write README content to file
    with open("README.md", "w") as f:
        f.write(readme_content)

    print("README.md file generated successfully.")

if __name__ == "__main__":
    main()
