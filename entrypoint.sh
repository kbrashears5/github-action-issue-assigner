#!/bin/bash

echo "Repository: [$GITHUB_REPOSITORY]"

GITHUB_TOKEN="$INPUT_TOKEN"

echo " "

# determine repo info
REPO_INFO=($(echo $GITHUB_REPOSITORY | tr "/" "\n"))
USER_NAME=${REPO_INFO[0]}
echo "Username: [$USER_NAME]"
REPO_NAME=${REPO_INFO[1]}
echo "Repository name: [$REPO_NAME]"

echo " "

# get latest issue
echo "Getting latest issue on [${REPO_NAME}]"
ISSUES=$(curl -X GET -H "Accept: application/vnd.github.v3+json" -u ${USERNAME}:${GITHUB_TOKEN} --silent "${GITHUB_API_URL}/repos/${GITHUB_REPOSITORY}/issues?sort=updated&direction=asc&state=open&per_page=1" | jq '.[].id')
readarray -t ISSUE_IDS <<< "$ISSUES"
ID="${ISSUES[0]}"
echo "Issue ID: [${ID}]"

# turn repo username into array
readarray -t ASSIGNEES <<< "$USER_NAME"
ASSIGNEES_JSON=`printf '%s\n' "${ASSIGNEES[@]}" | jq -R . | jq -s .`

echo " "

# assign issue
echo "Assigning issue to [${USER_NAME}]"
    jq -n \
    --argjson assignees $ASSIGNEES_JSON \
    '{
        assignees:$assignees
    }' \
    | curl -d @- \
        -X POST \
        -H "Accept: application/vnd.github.v3+json" \
        -H "Content-Type: application/json" \
        -u ${USERNAME}:${GITHUB_TOKEN} \
        --silent \
        ${GITHUB_API_URL}/repos/${repository}/issues/${ID}/assignees