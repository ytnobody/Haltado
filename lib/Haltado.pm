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
    $opts{parser} = $class->init_parser( $opts{parser} );
    $opts{actions} ||= [ 'Echo' ];
    $opts{actions} = $class->init_actions( $opts{actions} );
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
    my %options = $self->{parser_options} ? %{$self->{parser_options}} : ();
    while (1) { 
        if ( my $q = $fifo->getline ) {
            $self->do_actions( $parser, $parser->new(%options)->($q) );
        }
        else {
            $fifo->seek(0,0);
            Time::HiRes::sleep $self->{interval};
        }
    }
}

sub do_actions {
    my ( $self, $class, $data ) = @_;
    map { $data = $_->( $class, $data ) } @{$self->{actions}};
    return $data;
}

sub init_parser {
    my ( $class, $parser ) = @_;
    $parser ||= 'Raw';
    my $klass = join '::', $class, 'Parser', $parser; 
    load_class( $klass );
    return $klass;
}

sub init_actions {
    my ( $class, $actions ) = @_;
    return [ 
        map { 
            load_class( $_->{class} ); 
            my $class = delete $_->{class}; 
            $class->new( %$_ );
        }
        map { $_->{class} = join '::', $class, 'Action', $_->{class}; $_ }
        map { $_ = ref $_ eq 'HASH' ? $_ : { class => $_ } }
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
