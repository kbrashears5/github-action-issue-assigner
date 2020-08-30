<h1 align="center">github-action-issue-assigner</h1>


<div align="center">

<b>Github Action to assign newly created issues to code owner</b>

[![version](https://img.shields.io/github/v/release/kbrashears5/github-action-issue-assigner)](https://img.shields.io/github/v/release/kbrashears5/github-action-issue-assigner)

</div>


# Use Cases
Notifications do not get generated for when a new issue is created on a repo, other than if it's assigned to someone, from what I've found.

I created this Github Action to alert me when an issue is opened by assigning it to myself - thus creating an email notification from Github

# Setup
Create a new file called `/.github/workflows/issue-assigner.yml` that looks like so:
```yaml
name: Issue Assigner

on:
  issues:
    types: [opened]

jobs:
  issue_assigner:
    runs-on: ubuntu-latest
    steps:
      - name: Issue Assigner
        uses: kbrashears5/github-action-issue-assigner@v1.0.0
        with:
          TOKEN: ${{ secrets.ACTIONS }}
```
## Parameters
| Parameter | Required | Description |
| --- | --- | --- |
| TOKEN | true | Personal Access Token with Repo scope |