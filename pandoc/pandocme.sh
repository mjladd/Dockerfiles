#!/bin/bash

docker run --rm --volume "$(pwd):/data" --user $(id -u):$(id -g) pandoc/latex  python_cheat_sheet.md -o python_cheat_sheet.pdf

