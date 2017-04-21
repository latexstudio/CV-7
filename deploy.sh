#!/bin/bash
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "master" ]; then exit 0; fi
set -o errexit

rm -rf public
mkdir public

# config
git config --global user.email "theo@dammaretz.fr"
git config --global user.name "Blightwidow"

# build
cd src
xelatex -interaction=nonstopmode -halt-on-error -output-directory ../public cv.tex
cd ..

# deploy
cd public
git init
git add .
git commit -m "Deploy to Buiild branch"
git push --force "https://${GH_TOKEN}@github.com/${GITHUB_REPO}.git" master:build > /dev/null 2>&1
