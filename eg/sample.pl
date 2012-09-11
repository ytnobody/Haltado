#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib ( "$FindBin::Bin/../lib" );
use Haltado;

my $c = Haltado->new( file => '/tmp/foo', action => [ 'Parse::AccessLogEntry' ] );
$c->poll;
