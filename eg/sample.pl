#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib ( "$FindBin::Bin/../lib" );
use Haltado;

my $c = Haltado->new( 
    file => '/tmp/foo', 
    parser => 'Syslog', 
    actions => [
        'ToJSON',
        { class => 'Throw::HTTP', url => 'http://localhost:5000/' }
    ],
);
$c->poll;
