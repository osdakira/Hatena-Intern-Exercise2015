package Log;
use strict;
use warnings;
use Time::Piece;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub protocol {
  my $self = shift;
  $self->{req} =~ /HTTP.+$/p;
  return ${^MATCH};
}

sub method {
  my $self = shift;
  $self->{req} =~ /^[A-Z]+/p;
  return ${^MATCH};
}

sub path {
  my $self = shift;
  my @path = split(/ /, $self->{req});
  return $path[1];
}

sub uri {
  my $self = shift;
  return 'http://' . $self->{host} . $self->path;
}

sub time {
  my $self = shift;
  my $t = Time::Piece::gmtime($self->{epoch});
  return $t->datetime;
}

1;
