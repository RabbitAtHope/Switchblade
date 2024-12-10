#!/bin/bash

echo ""

#//////////////////////////

echo "Finding all [.git] files..."

sudo find / -type f -iname .git

echo ""

#//////////////////////////

echo "Finding all [.gitattributes] files..."

sudo find / -type f -iname .gitattributes

echo ""

#//////////////////////////

echo "Finding all [.github] files..."

sudo find / -type f -iname .github

echo ""

#//////////////////////////

echo "Finding all [.gitignore] files..."

sudo find / -type f -iname .gitignore

echo ""

#//////////////////////////

echo "Finding all [.gitmodules] files..."

sudo find / -type f -iname .gitmodules

echo ""

#//////////////////////////