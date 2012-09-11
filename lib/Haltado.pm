package Haltado;
use strict;
use warnings;
our $VERSION = '0.01';

use POSIX 'mkfifo';
use IO::File;
use Time::HiRes;
use Class::Load ':all';
use JSON;

our $JSON = JSON->new->utf8;

sub new {
    my ( $class, %opts ) = @_;
    $opts{interval} ||= 1;
    $opts{parser} = $class->init_parser( $opts{parser} );
    return bless { %opts }, $class;
}

sub fifo {
    my $self = shift;
    my $file = $self->{file};
    mkfifo( $file, 0755 ) unless -e $file;
    return IO::File->new( $file, 'r' );
}

sub poll {
    my $self = shift;
    my $fifo = $self->fifo;
    my $parser = $self->{parser};
    while (1) { 
        if ( my $q = $fifo->getline ) {
            printf "%s\n", json_res( $parser, $parser->new->($q) );
        }
        else {
            $fifo->seek(0,0);
            Time::HiRes::sleep $self->{interval};
        }
    }
}

sub json_res {
    my ( $class, $data ) = @_;
    return $JSON->encode( { 
        scheme => $class, 
        data => $data
    } );
}

sub init_parser {
    my ( $class, $parser ) = @_;
    $parser ||= 'Raw';
    my $klass = join '::', $class, 'Parser', $parser; 
    load_class( $klass );
warn $klass;
    return $klass;
}
 
1;
__END__

=head1 NAME

Haltado -

=head1 SYNOPSIS

  use Haltado;

=head1 DESCRIPTION

Haltado is

=head1 AUTHOR

ytnobody E<lt>ytnobody@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
