#!/bin/bash
urls=(
    'https://raw.githubusercontent.com/Theros-org/cash-eligibility-service/master/README.md'
    'https://raw.githubusercontent.com/Theros-org/.github-private/master/profile/README.MD'
)

file_directory='./documents/github/'
mkdir -p $file_directory

for url in "${urls[@]}"
do
    IFS='/'
    testarray=($url)
    unset IFS
    directory="$file_directory${testarray[4]}"
    mkdir -p $directory

    curl \
        -H "Authorization: token $TOKEN" \
        -H "Accept: application/vnd.github.v3.raw" \
        -o $directory/$(basename $url) \
        -L $url
done
