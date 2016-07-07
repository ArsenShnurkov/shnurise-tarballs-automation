#!/bin/bash

read -d '' TEST << EOF
  dog
  whale
EOF

echo -n "The $TEST has "
case $TEST in
  horse | dog | cat) echo -n "four";;
  man | kangaroo ) echo -n "two";;
  */*) echo -n "**";;
  *) echo -n "an unknown number of";;
esac
echo " legs."
