# -*- coding: utf-8 -*-
"""
    Jellybeans Colorscheme
    ~~~~~~~~~~~~~~~~~~~~~~
    Converted by Vim Colorscheme Converter
"""
from pygments.style import Style
from pygments.token import Token, Keyword, Number, Comment, Name, Operator, String, Generic

class JellybeansStyle(Style):

    background_color = '#121212'
    styles = {
        Token:              'noinherit #d7d7d7 bg:#121212', # Standard white text
        Generic.Traceback:  'noinherit bg:#d75f5f', # Red BG
        Generic.Heading:    '#87af5f bold', # green strings
        Comment.Preproc:    'noinherit #8fbfdc',
        Name.Cmnstant:      'noinherit #cf6a4c',
        Generic.Subheading: '#87af5f bold', # green strings
        Keyword:            'noinherit #8197bf',
        Name.Tag:           'noinherit #8197bf',
        Generic.Inserted:   'noinherit bg:#032218',
        Keyword.Type:       'noinherit #ffb964',
        Name.Variable:      'noinherit #c6b6ee',
        Generic.Deleted:    'noinherit #220000 bg:#220000',
        Number:             'noinherit #cf6a4c',
        Operator.Word:      'noinherit #e8e8d3 bg:#151515',
        Name.Function:      'noinherit #fad07a',
        Name.Entity:        'noinherit #799d6a',
        Name.Exception:     'noinherit #ffb964',
        Comment:            'noinherit #888888 italic',
        Generic.Output:     'noinherit #808080 bg:#151515',
        Name.Attribute:     'noinherit #fad07a',
        String:             'noinherit #99ad6a',
        Name.Label:         'noinherit #ffb964',
        Generic.Error:      'noinherit bg:#d75f5f', # red bg
    }
