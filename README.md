WSLHTMLEntities
===============

Convert HTML Entities like &amp;rsaquo; to their unicode equivalent.

Adding to your project
======================

If you're using iOS 5 or above and are happy with ARC, you can just add
the libWSLHTMLEntities.a file to your project and then you're good to
go. The other target, called "WSLHTMLEntities Sample" just shows you
how to use the code.

If you want to do it the hard, old way you just need to copy the
following four files -- or at least references to them -- into your
project:

* WSLHTMLEntities.h
* WSLHTMLEntities.m
* WSLHTMLEntities.lm
* WSLHTMLEntityDefinitions.h

The project has no releases, retains or autoreleases so it works
whether you prefer ARC or not.

Usage
=====

There's only one method:

+(NSString*)convertHTMLtoString:(NSString*)html;

I'm sure you can figure out how to use it.

You can also use the instance method if you like:

WSLHTMLEntities* parser = [[WSLHTMLEntities alloc] init];
NSString* out = [parser convertHTMLtoString:in];

This may be slightly quicker if you're processing lots of strings.

WSLHTMLEntities is now thread-safe.

Maintenance
===========

The lexer is based on HTML::Entities from CPAN (Perl). You can (mostly)
generate the lexer and #define's with genEntitiesLexer.pl, but you
would only need to do that it you want to add a new entity. Or there's
a bug.

In the wild
===========

It's used in the following apps:

* [Yummy](http://www.wandlesoftware.com/products/yummy)
* [www.cut](http://www.wandlesoftware.com/products/www-cut)

Please let me know if you use it in yours.

Copyright
=========

I'm not sure there's enough code from the Perl version to "taint" it but
I don't have expensive lawyers like Google so I'm playing it safe and
using the same licence. Basically you can do what you like with it but
credits and push requests would be welcome.

Copyright 2012 Stephen Darlington. Wandle Software Limited. All
rights reserved.

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
