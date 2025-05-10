#!/bin/bash
rsync -avz --exclude '.git' . yourusername@rpi5.local:/etc/nixos/
ssh yourusername@rpi5.local "sudo nixos-rebuild switch --flake /etc/nixos#rpi5"