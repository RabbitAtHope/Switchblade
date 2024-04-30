#!/bin/bash
sudo systemctl restart pc-app-server 2> /dev/null

echo "[Success] Restarted the PaperCut web app printing service, if present."