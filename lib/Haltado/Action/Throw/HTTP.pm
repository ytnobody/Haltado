package Haltado::Action::Throw::HTTP;
use strict;
use warnings;
use parent 'Haltado::Action::ToJSON';
use Furl;
use HTTP::Request::Common;
use Data::Dumper;

our $VERSION = 0.01;

sub new {
    my ( $class, %opts ) = @_;
    my $agent = Furl->new( agent => join('/', $class, $VERSION) );
    my $super = $class->SUPER::new();
    my $url = $opts{url};
    return bless sub {
        my ( $class, $data ) = @_;
        my $json = $super->($class, $data);
        my $req = POST( $url, 
            Content_Type => 'application/json', 
            Content => $json
        );
        $agent->request( $req );
    }, $class;
}

1;
