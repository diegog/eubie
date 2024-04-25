import os
import requests

urls = [
    'https://raw.githubusercontent.com/github/docs/main/README.md',
    'https://raw.githubusercontent.com/Azure-Samples/azure-search-openai-demo/main/README.md',
    'https://raw.githubusercontent.com/microsoft/AI/master/README.md',
]

documents_folder = os.path.join(os.getcwd(), '.', 'documents')
os.makedirs(documents_folder, exist_ok=True)

for url in urls:
    response = requests.get(url)
    if response.status_code == 200:
        filename = url.split('/')[-3] + '_' + url.split('/')[-1]
        with open(os.path.join(documents_folder, filename), 'wb') as file:
            file.write(response.content)
        print(f"File '{filename}' saved successfully.")
    else:
        print(f"Failed to retrieve file from URL: {url}")
