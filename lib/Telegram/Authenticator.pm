package Telegram::Authenticator;
use strict;
use warnings FATAL => 'all';

#**********************************************************
=head2 new($attr)

  Arguments:
   $attr - hash_ref
     realms - hash_ref
       realm_id => name
    
  Returns:
    object
    
=cut
#**********************************************************
sub new {
  my $class = shift;
  
  my ($attr) = @_;
  
  my $self = {};
  
  bless($self, $class);
  
  return $self;
}

#**********************************************************
=head2 authenticate()

=cut
#**********************************************************
sub authenticate {
  return 1;
}

#**********************************************************
=head2 is_authenticated()

=cut
#**********************************************************
sub is_authenticated {
  return 1;
}

#**********************************************************
=head2 save_auth()

=cut
#**********************************************************
sub save_auth {
  return 1;
}


1;