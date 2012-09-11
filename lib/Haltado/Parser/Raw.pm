package Haltado::Parser::Raw;
use strict;
use warnings;

sub new {
    my $class = shift;
    return bless sub { return shift }, $class;
}

1;
