package CoffeeShop::Administrators;
use strict;
use warnings FATAL => 'all';
use CoffeeShop::DB qw/resultset/;
my $Admins = resultset('Administrator');
#**********************************************************
=head2 get_by_login($login)

  Arguments:
    $login -
    
  Returns:
  
=cut
#**********************************************************
sub get_by_login {
  my (
    $login) =
    @_;
  
  my $Admin = $Admins->find({login => $login});
  
  return $Admin;
}

#**********************************************************
=head2 get_all()

  Arguments:
     -
    
  Returns:
  
=cut
#**********************************************************
sub get_all {
  return $Admins->search()->all;
}

1;