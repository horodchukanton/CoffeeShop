package CoffeeShop::Registration::PinChecker;
use strict;
use warnings FATAL => 'all';

=head1 NAME

  CoffeeShop::Registration

=head2 SYNOPSIS

  This package manages registration requests

=cut


#**********************************************************
=head2 new(\%config) - constructor for CoffeeShop::Registration

=cut
#**********************************************************
sub new {
  my $class = shift;
  my ($config) = @_;
  
  my $self = {
    config           => $config,
    pin_length       => 4,
    symbols          => [ 'a' ... 'z', 0 ... 9 ],
    current_requests => {}
  };
  
  $self->{symbols_count} = scalar(@{$self->{symbols}});
  
  srand();
  
  bless($self, $class);
  return $self;
}

#**********************************************************
=head2 create_request() - will create a request and store in memory

  Arguments:
     -
    
  Returns:
  
  
=cut
#**********************************************************
sub create_request {
  my ($self, $text) = @_;
  
  # Make random value
  my $new_pin = '';
  for ( my $i = 0; $i < $self->{pin_length}; $i++ ) {
    my $pos = int(rand($self->{symbols_count}));
    $new_pin .= $self->{symbols}->[$pos];
  }
  
  # Save
  $self->{current_requests}->{$new_pin} = $text;
  
  return $new_pin;
}

# Check has such sign
#**********************************************************
=head2 check_pin($pin) - checks PIN

  Arguments:
    $pin -
    
  Returns:
  
  
=cut
#**********************************************************
sub check_pin {
  my ($self, $pin) = @_;
  
  if (exists $self->{current_requests}{$pin}){
    my $value = $self->{current_requests}{$pin};
    delete $self->{current_requests}{$pin};
    return $value;
  }
  
  return;
}



1;