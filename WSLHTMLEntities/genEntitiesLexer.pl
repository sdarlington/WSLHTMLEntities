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

use strict;
use warnings;

foreach (@ARGV) {
  open (FH, $_) or die;
  print "#define WSL_ENTITIY_NOTB -1\n";
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
