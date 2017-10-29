package Telegram::Autheticator::Disabled;
use strict;
use warnings FATAL => 'all';

use Telegram::Authenticator;
use parent 'Telegram::Authenticator';

my %authenticated = ();

#**********************************************************
=head2 authenticate()

=cut
#**********************************************************
sub authenticate {
  my ($chat_id, $auth_params) = @_;
  
  save_auth($chat_id);
  
  return 1;
}

#**********************************************************
=head2 is_authenticated()

=cut
#**********************************************************
sub is_authenticated {
  my ($chat_id) = shift;
  
  return $authenticated{$chat_id};
}

#**********************************************************
=head2 save_auth()

=cut
#**********************************************************
sub save_auth {
  my ($chat_id) = shift;
  $authenticated{$chat_id} = 1;
  return 1;
}


1;