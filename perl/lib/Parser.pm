package Parser;
use 5.10.0;
use strict;
use warnings;
use Data::Dumper;
use Log;
use Pry;

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

sub parse {
  my ($self) = @_;
  open my $fh, '<', $self->{filename} or die $!;
  my @lines = <$fh>;
  my @logs = map({
    chomp($_);
    my @cols = split(/\t/, $_);
    my %log = map { split(/:/, $_, 2) } @cols;
    %log = map { %log{$_} } grep { $log{$_} ne '-' } keys %log;
    Log->new(%log);
  } @lines);
  # pry;
  return \@logs;
}

1;
