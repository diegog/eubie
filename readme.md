# Eubie

Eubie is a Retrieval-Augmented generation ([RAG](https://en.wikipedia.org/wiki/Prompt_engineering#Retrieval-augmented_generation)) pipeline that utilizes github actions, terraform and azure functions to retrieve, vectorize and store documents.

Name inspired by [Eubie Blake](https://en.wikipedia.org/wiki/Eubie_Blake), a composer and pianist of ragtime, jazz, and popular music.

## Overview

The pipeline will consist of the following steps:

1. Retrieve documents from external sources
2. Store documents in Azure blob storage
3. Vectorize documents
    - Use an azure function to vectorize documents as soon as there are changes in the documents folder in blob storage
    - Use one of azure's AI services to vectorize the documents
4. Store vectors in Azure vector db
5. Use vectors to generate prompts for a language model

## Usage

Usage of this repository is simple. Add your personal access token to the secrets of the repository and run the github actions. The actions will run terraform to create the infrastructure, retrieve the documents, and then store them in Azure. You can also set a schedule for the action to run at a specific time or interval.

To add your own retrieval functions, simply add a new function in the `retrieval` folder. The function should be a python script that takes no arguments stores any documents in the `documents` folder. The `documents` folder will be uploaded to Azure blob storage. **Note**: The documents folder will not be uploaded to the repository, it will be created during the github action run.

## Goals

For sake of learning and fun, I am limiting myself to use terraform and infrastructure as code to build the pipeline. This will allow for a more reproducible and scalable solution right from the start.

## TODO

- [ ] Look for minimun infrastructure requirements in azure (this will be useful for terraform)
    - [ ] Document storage
    - [ ] Vector db
    - [ ] AI infrastructure
    - [ ] Azure Functions
- [ ] Create functions to retrieve data from external sources
    - [x] Readme from GitHub
    - [ ] Documents from Google
    - [ ] Documents from Confluence
    - [ ] Slack message history
- [ ] Github actions
    - [ ] Runs terraform plan / apply
    - [x] Runs retrieval functions
    - [ ] Uploads data to Azure
- [ ] Azure Functions (try to do this all in terraform)
    - [ ] Run vectorization of documents when uploaded
