package Haltado::Action::Echo;
use strict;
use warnings;

sub new {
    return bless sub {
        my $q = shift;
        print $q;
    }, shift;
}

1;
