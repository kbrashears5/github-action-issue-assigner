# github-action-issue-assigner

Github Action to assign newly created issues to code owner

[![version](https://img.shields.io/github/v/release/kbrashears5/github-action-issue-assigner)](https://img.shields.io/github/v/release/kbrashears5/github-action-issue-assigner)

# Use Cases
Notifications do not get generated for when a new issue is created on a repo, other than if it's assigned to yourself, or you're mentioned, from what I've found.

I created this Github Action to alert me when an issue is opened by assigning it to myself - thus creating an email notification and/or a mobile push notification from Github

# Setup
Create a new file called `/.github/workflows/issue-assigner.yml` that looks like so:
```yaml
name: Issue Assigner

on:
  issues:
    types: [opened]
  pull_request:
    types: [opened]

jobs:
  issue_assigner:
    runs-on: ubuntu-latest
    steps:
      - name: Issue Assigner
        uses: kbrashears5/github-action-issue-assigner@v1.0.0
        with:
          TOKEN: ${{ secrets.TOKEN }}
```
## Parameters
| Parameter | Required | Description |
| --- | --- | --- |
| TOKEN | true | Personal Access Token with Repo scope. See below for details on running as yourself or as a bot |

## Running as your own account
Create a Personal Access Token with repo:public_repo scope.

Create a new secret in your repository and reference it in the yaml above, using the script in the `Creating Token` section to encode your username and token.

In order to receive email notifications, you must have the following checked on your [Email Notification Preferences](https://github.com/settings/notifications):
- Comments on Issues and Pull Requests
- Include your own updates

Note: Enabling this can create a lot of noise in your inbox

## Running as a bot account
You'll need to create a new github account to be your bot. If you use gmail, then you can use your original email, add `+bot` or something similar in order to have the account be signed up for the same email. Other email providers provide this as well. Example below:

Original
> example.email@gmail.com

Bot
> example.email+bot@gmail.com

You'll get account emails to your same email (I actually turned off all email notifications in my bot account), and be able to have two github accounts.

Next, setup a Personal Access Token in your new bot account with repo:public_repo scope. This allows the bot the ability to create comments on issues. Unfortunately only admins or collaborators can assign issues, so this won't be able to assign them to yourself without another step.

Create a new secret in your repository and reference it in the yaml above.

Once the PAT is setup, you will be able to browse issues by seeing them [mentioned](https://github.com/.issues/mentioned) in your account.

If you would like to be able to browse by [assigned](https://github.com/.issues/assigned), then you'll need to invite your new bot account as a collaborator to the repo.