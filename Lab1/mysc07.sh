#!/bin/bash
str="[[:alnum:]]+@[[:alnum:]]+(\.[[:alnum:]]+)+"
grep -Eosh $str /etc/* | awk '{printf("%s, ",$1)}' | sed s/,.\$/\\n/ > email.lst