#!/bin/bash

bash sc41&
task1=$!
bash sc41&
task2=$!
bash sc41&
task3=$!

renice 20 -p $task1
at now + 1 minute <<< "kill $task3"
at now + 2 minute <<< "kill $task1"
at now + 3 minute <<< "kill $task2"