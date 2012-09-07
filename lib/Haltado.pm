package Haltado;
use strict;
use warnings;
our $VERSION = '0.01';

use POSIX 'mkfifo';
use IO::File;
use Time::HiRes;
use Class::Load ':all';

sub new {
    my ( $class, %opts ) = @_;
    $opts{interval} ||= 1;
    $opts{action} = $class->init_action( $opts{action} );
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
    while (1) { 
        if ( my $q = $fifo->getline ) {
            $_->new->($q) for @{$self->{action}};
        }
        else {
            $fifo->seek(0,0);
            Time::HiRes::sleep $self->{interval};
        }
    }
}

sub init_action {
    my ( $class, $actions ) = @_;
    $actions ||= [ 'Echo' ];
    return [ 
        map { load_class($_); $_ } 
        map { join '::', $class, 'Action', $_ } 
        @$actions 
    ];
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
