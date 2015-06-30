#!/usr/bin/env python
import sys
for line in sys.stdin:
    line = line.strip()
    items = line.split(',')
    label = items[1]
    features = items[2].replace('"', '')
    print '%s | %s'%(label, features)
