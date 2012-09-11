package Haltado::Parser::AccessLog;
use strict;
use warnings;
use Parse::AccessLogEntry;

our $PARSER = Parse::AccessLogEntry->new;

sub new {
    return bless sub {
        my $q = shift;
        my $res = $PARSER->parse( $q );
        delete $res->{datetime_obj};
        return $res;
    }, shift;
}

1;
