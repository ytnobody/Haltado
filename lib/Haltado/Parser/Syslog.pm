package Haltado::Parser::Syslog;
use strict;
use warnings;
use Parse::Syslog::Line 'parse_syslog_line';

sub new {
    return bless sub {
        my $q = shift;
        my $res = parse_syslog_line( $q );
        delete $res->{datetime_obj};
        return $res;
    }, shift;
}

1;
