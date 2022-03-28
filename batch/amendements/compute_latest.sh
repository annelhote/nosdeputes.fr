#!/bin/bash

source ../../bin/init_pyenv27.sh

mkdir -p json

if [ -e to_parse.list ]; then
  for file in `cat to_parse.list`; do
    echo $file
    output=`echo $file | sed 's/html\//json\//'`
    perl parse_amdmt.pl $file | python clean_subjects_amdmts.py > $output
  done
fi

