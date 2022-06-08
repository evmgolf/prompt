#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import sys
import base64

def decode(obj):
    if isinstance(obj, dict):
        return {
            key: decode(value)
            for key, value in obj.items()
        }
    elif isinstance(obj, list):
        return list(map(decode, obj))
    elif isinstance(obj, str):
        if obj.startswith('data:'):
            obj = obj[len('data:'):]
            kind, obj = obj.split(';', maxsplit=1)
            if obj.startswith('base64,'):
                obj = base64.b64decode(obj[len('base64,'):])
            if kind == 'application/json':
                obj = json.loads(obj)
            return obj

        else:
            return obj
    else:
        return obj

print(json.dumps(decode(json.loads(sys.stdin.read()))))
