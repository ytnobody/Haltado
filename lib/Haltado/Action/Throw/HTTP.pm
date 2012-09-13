package Haltado::Action::Throw::HTTP;
use strict;
use warnings;
use Furl;
use HTTP::Request::Common;

our $VERSION = 0.01;

sub new {
    my ( $class, %opts ) = @_;
    my $agent = Furl->new( agent => join('/', $class, $VERSION) );
    my $type = $opts{type} || 'text/plain';
    my $url = $opts{url};
    return bless sub {
        my ( $class, $data ) = @_;
        my $req = POST( $url, 
            Content_Type => $type, 
            Content => $data,
        );
        $agent->request( $req );
        return $data;
    }, $class;
}

1;
