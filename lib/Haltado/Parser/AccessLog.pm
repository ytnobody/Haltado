package Haltado::Parser::AccessLog;
use strict;
use warnings;
use Parse::AccessLogEntry;

sub new {
    my $class = shift;
    my $parser = Parse::AccessLogEntry->new( @_ );
    return bless sub {
        my $q = shift;
        my $res = $PARSER->parse( $q );
        delete $res->{datetime_obj};
        return $res;
    }, $class;
}

1;
