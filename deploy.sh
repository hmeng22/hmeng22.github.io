#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Push source
git add --all && git commit -m "Rebuilding 'date'"
git push origin gh-pages

# Build the project.
hugo -t hemingway # if using a theme, replace with `hugo -t <YOURTHEME>`

# Publish github pages
cd public && git add --all && git commit -m "Publishing 'date'"
git push origin master