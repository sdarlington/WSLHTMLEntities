WSLHTMLEntities
===============

Convert HTML Entities like &amp;rsaquo; to their unicode equivalent.

Useage
======

You just need the following four files:

* WSLHTMLEntities.h
* WSLHTMLEntities.m
* WSLHTMLEntities.lm
* WSLHTMLEntityDefinitions.h

The other files just show how to use it.

There's only one method:

+(NSString*)convertHTMLtoString:(NSString*)html;

I'm sure you can figure out how to use it.

It includes HTML::Entities from CPAN (Perl). You can (mostly) generate the lexer and #define's with genEntitiesLexer.pl, but you would only need to do that it you want to add a new entity. Or there's a bug.

Copyright
=========

I'm not sure there's enough code from the Perl version to "taint" it but I don't have expensive lawyers like Google so I'm playing it safe and using the same licence. Basically you can do what you like with it but credits and push requests would be welcome.

Copyright 2012 Stephen Darlington. Wandle Software Limited. All rights reserved.

This library is free software; you can redistribute it and/or modify it under the same terms as Perl itself.
