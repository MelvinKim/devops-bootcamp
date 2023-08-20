#!/bin/sh
echo "hello Jeffery!" | kcat -P -b localhost:9092 -t test
