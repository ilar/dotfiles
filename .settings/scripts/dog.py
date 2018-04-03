#!/usr/bin/env python
# -*- coding: iso-8859-15 -*-

from pygments.lexers import guess_lexer
from pygments.formatters.terminal256 import Terminal256Formatter
from jellybeans import JellybeansStyle
import sys

if not len(sys.argv) > 1:
    sys.exit(-1)

code = ''
with open(sys.argv[1], 'r') as f:
    for line in f:
        code += line

lex = guess_lexer(code)
fmt = Terminal256Formatter(style=JellybeansStyle)

print(highlight(code, lex, fmt))
