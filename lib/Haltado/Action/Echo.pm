package Haltado::Action::Echo;
use strict;
use warnings;

sub new {
    my $class = shift;
    return bless sub {
        my ( $class, $data ) = @_;
        printf "%s\n", $data;
    };
}

1;
