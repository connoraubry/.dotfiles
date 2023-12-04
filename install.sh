#!/bin/bash

set -euxo pipefail
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p ~/.config/tmux
cp $SCRIPT_DIR/tmux.conf ~/.config/tmux/tmux.conf

cp $SCRIPT_DIR/zshrc ~/.zshrc

