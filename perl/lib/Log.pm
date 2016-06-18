package Log;
use strict;
use warnings;
use Time::Piece;
use Data::Dumper;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub protocol {
  my ($self) = @_;
  $self->{req} =~ /HTTP.+$/p;
  return ${^MATCH};
}

sub method {
  my ($self) = @_;
  $self->{req} =~ /^[A-Z]+/p;
  return ${^MATCH};
}

sub path {
  my ($self) = @_;
  my @path = split(/ /, $self->{req});
  return $path[1];
}

sub uri {
  my ($self) = @_;
  return 'http://' . $self->{host} . $self->path;
}

sub time {
  my ($self) = @_;
  my $t = Time::Piece::gmtime($self->{epoch});
  return $t->datetime;
}

sub to_hash {
  my ($self) = @_;
  my $attrs = ['status', 'time', 'size', 'uri', 'user', 'method', 'referer'];
  my %hash = map({ ($_, $self->can($_) ? $self->$_ : $self->{$_}) } @$attrs);
  %hash = map { ($_, $hash{$_}) } grep { defined($hash{$_}) } keys %hash;
  return \%hash;
}

1;
