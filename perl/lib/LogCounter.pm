package LogCounter;
use strict;
use warnings;

use Data::Dumper;
use Pry;

sub new {
    my ($class, $logs) = @_;
    return bless { logs => $logs }, $class;
};

sub group_by_user {
  my ($self) = @_;
  my $hash = {};
  my @logs = map { @$_ } $self->{logs};
  foreach my $log (@logs) {
    my $user = $log->{user} || "guest";
    unless (${$hash}{$user}) {
      ${$hash}{$user} = [];
    }
    push(@{${$hash}{$user}}, $log);
  }
  return $hash;
}

sub count_error {
  my ($self) = @_;
  my $count = grep { $_->{status} =~ /^5/ } map { @$_ } $self->{logs};
  return $count;
}

1;
