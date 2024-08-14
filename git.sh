#!/usr/bin/env sh

git -C /safe/data/nix add -A

git -C /safe/data/nix commit -m 'Local changes autocommit'

git -C /safe/data/nix push
