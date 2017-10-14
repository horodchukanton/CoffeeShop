package Telegram::Autheticator::Disabled;
use strict;
use warnings FATAL => 'all';

use Telegram::Authenticator;
use parent 'Telegram::Authenticator';

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