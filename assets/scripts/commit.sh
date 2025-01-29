#!/usr/bin/env bash
git status
TYPE=$(gum choose "fix" "feat" "docs" "style" "refactor" "test" "chore" "revert" "build" "ci")
SCOPE=$(gum input --placeholder "scope")

test -n "$SCOPE" && SCOPE="($SCOPE)"

SUMMARY=$(gum input --value "$TYPE$SCOPE: " --placeholder "Summary of this change")
DESCRIPTION=$(gum write --placeholder "Details of this change")

gum confirm "Commit changes?" && git commit -m "$SUMMARY" -m "$DESCRIPTION"
