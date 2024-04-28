# Eubie

Eubie is an Automated Retrieval-Augmented generation ([RAG](https://en.wikipedia.org/wiki/Prompt_engineering#Retrieval-augmented_generation)) pipeline that utilizes github actions, terraform and azure functions to retrieve, index, and query these documents with ChatGPT.

Name inspired by [Eubie Blake](https://en.wikipedia.org/wiki/Eubie_Blake), a composer and pianist of ragtime, jazz, and popular music.

### Goals

For sake of learning and fun, I am setting a goal of using terraform to provision the resources for the pipeline and minimize the need to use the portal. This will allow for a more reproducible and scalable solution right from the start.

## Infrastructure

![Architecture Diagram](.github/images/architecture-diagram.png)

### Azure Resources

Azure resources will be provisioned using terraform. The resources will include:

- Resource Group
- Storage Account
  - Blob Storage Container
- Azure Search Service
- Azure OpenAI Service
  - Chat model: gpt-35-turbo
  - Embedding model: text-embedding-ada-002

### Pipeline

The pipeline will consist of the following steps:

1. Retrieve documents from external sources
2. Store documents in Azure blob storage
3. Index documents
    - Use an azure function to vectorize documents as soon as there are changes in the documents folder in blob storage
    - Use one of azure's AI services to vectorize the documents
4. Interact with indexed documents with ChatGPT

## Usage

Usage of this repository is simple. Add your personal access token to the secrets of the repository and run the github actions. The actions will run terraform to create the infrastructure, retrieve the documents, and then store them in Azure. You can also set a schedule for the action to run at a specific time or interval.

To add your own retrieval functions, simply add a new function in the `retrieval` folder. The function should be a python script that takes no arguments stores any documents in the `documents` folder. The `documents` folder will be uploaded to Azure blob storage. **Note**: The documents folder will not be uploaded to the repository, it will be created during the github action run.

## TODO

- [x] Github actions
    - [x] Runs terraform plan / apply
    - [x] Runs retrieval functions
    - [x] Uploads data to Azure
- [ ] Deploy infrastructure with terraform
    - [x] Document storage
    - [x] OpenAI Service
    - [x] Search Service
        - [ ] Add indexer
    - [ ] Azure Functions
        - [ ] Run indexer when uploaded to blob storage
- [ ] Create functions to retrieve data from external sources
    - [x] Readme from GitHub
    - [ ] Documents from Google
    - [ ] Documents from Confluence
    - [ ] Slack message history
- [ ] Create a frontend
