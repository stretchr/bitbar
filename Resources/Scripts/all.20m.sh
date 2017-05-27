#!/bin/bash

SCRIPT=/usr/bin/whoami
IMGURL="https://github.com/oleander/bitbar/raw/master/Resources/bitbar-2048.png"
IMG="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"
echo "[Title]"
echo "---"
echo "[Color(red)]| color=red"
echo "[Href]| href=http://google.com"
echo "[Checked true]| checked=true"
echo "[Checked false]| checked=false"
echo "[Alternate true]| alternate=true"
echo "[Alternate false]| alternate=false"
echo "[Truncated]| length=5"
echo "[Font Size 10]| size=10"
echo "[Font Family Times New Roman]| font='Times New Roman'"
echo "[Refresh true]| refresh=true"
echo "[Refresh false]| refresh=false"
echo "[:mushroom: true]| emojize=true"
echo "[:mushroom: false]| emojize=false"
echo "[Terminal true]| terminal=true bash='...'"
echo "[Terminal false]| terminal=false bash='...'"
echo "[Base64 Template Image]| templateImage=$IMG"
echo "[Base64 Image]| image=$IMG"
echo "[Url Template Image]| templateImage='$IMGURL'"
echo "[Url Image]| image='$IMGURL'"
echo -e "\e[9mstrikethrough\e[0m :car: \e[31mred\e[39m| ansi=true"
echo "[Dropdown true]| dropdown=true"
echo "--Submenu"
echo "[Dropdown false]| dropdown=false"
echo "--Submenu"
echo "Menu 1"
echo "--Menu 2"
echo "----Menu 3"
echo "------Menu 4"
echo "----Menu 5"
echo "--Menu 6"
echo "Menu 7"
echo "---"
echo "Menu 8"
echo "--Menu 9"
echo "-----"
echo "--Menu 10"
echo " [Trimmed true] | trim=true"
echo " [Trimmed false] | trim=false"
echo "[Href]|href=http://google.com"
echo "[Args]|bash='$SCRIPT' param2='' param0='A' param1=' B '"
# without script
echo "[Refresh]|refresh=true"
echo "Parent"
echo "--Child 1"
echo "----Child2|refresh=true"
# Test no refresh
echo "[Refresh]|refresh=false"
echo "Parent"
echo "--Child 1"
echo "----Child2|refresh=false"
# With script
echo "[Refresh]|refresh=true bash='$SCRIPT'"
echo "Parent"
echo "--Child 1"
echo "----Child2|refresh=true bash='$SCRIPT'"
# Test no refresh
echo "[Refresh]|refresh=false bash='$SCRIPT'"
echo "Parent"
echo "--Child 1"
echo "----Child2|refresh=false bash='$SCRIPT'"
# With script & terminal
echo "[Refresh]|refresh=true bash='$SCRIPT' terminal=true"
echo "Parent"
echo "--Child 1"
echo "----Child2|refresh=true bash='$SCRIPT' terminal=true"
# Test no refresh
echo "[Refresh]|refresh=false bash='$SCRIPT' terminal=false"
echo "Parent"
echo "--Child 1"
echo "----Child2|refresh=false bash='$SCRIPT' terminal=false"
# With href
echo "[Href]|href='http://google.com'"
echo "Parent"
echo "--Child 1"
echo "----Child2|href='http://google.com'"
# Test no refresh
echo "[Refresh]|href='http://google.com' refresh=true"
echo "Parent"
echo "--Child 1"
echo "----Child2|href='http://google.com' refresh=true"
# Script error
echo "[Refresh]|bash='exit 1'"
echo "Parent"
echo "--Child 1"
echo "----Child2|bash='exit 1'"
