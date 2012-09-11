package Haltado::Action::ToJSON;
use strict;
use warnings;
use JSON;

sub new {
    my $class = shift;
    my $JSON = JSON->new->utf8;
    return bless sub {
        my ( $scheme_class, $data ) = @_;
        return $JSON->encode( {
            class => $scheme_class,
            data => $data,
        } );
    }, $class;
}

1;
