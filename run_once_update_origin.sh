#! /usr/bin/env bash
cd "$HOME/.local/share/chezmoi"
git remote remove origin
git remote add origin git@github.com:fcharih/dotfiles.git
git branch --set-upstream-to=origin/main main

