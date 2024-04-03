#!/usr/bin/env sh

git -C ~/nix add -A

git -C ~/nix commit -m 'Local changes autocommit'

git -C ~/nix push
