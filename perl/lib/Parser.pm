package Parser;
use strict;
use warnings;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub parse {
  my $self = shift;
  open my $fh, '<', $self->{filename} or die $!;
  my @lines = <$fh>;
  print @lines;
}

1;
