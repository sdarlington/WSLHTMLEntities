#!/usr/bin/perl

#
#  genEntitiesLexer.pl
#  genEntitiesLexer
#
#  Created by Stephen Darlington on 05/06/2012.
#  Copyright (c) 2012 Wandle Software Limited. All rights reserved.
#


# Generate (most of) WSLHTMLEntityDefinitions.h (stdout) and WSLHTMLEntities.lm
# from the HTML::Entities Perl module.
# 
# Get the HTML::Entities file from http://cpansearch.perl.org/src/GAAS/HTML-Parser-3.69/lib/HTML/Entities.pm
# (Not included here because GitHub finds more Perl in the project and assumes
# that it's not an Objective-C project.)

use strict;
use warnings;

foreach (@ARGV) {
  open (FH, $_) or die;
  print "#define WSL_ENTITY_NOMATCH -1\n";
  while (<FH>) {
    chomp;
      my ($entity,$char,$comment) = m/^\s*'?([a-zA-Z]+);?'?\s+=>\s+chr\((\d+)\),(\s+# (.*))?$/;
      if (not defined $entity) {
        ($entity,$char,$comment) = m/^\s*'?([a-zA-Z]+);?'?\s+=>\s+['"](.+)['"],(\s+# (.*))?$/;
        $char = ord($char) if defined $char;
      }
      if (not defined $entity) {
          next;
      }
      print "#define WSL_ENTITY_$entity $char";
      print " // $comment" if defined $comment;
      print "\n";
      
      print STDERR "&${entity};   { return WSL_ENTITY_$entity; }\n";
  }
  close (FH);
}
