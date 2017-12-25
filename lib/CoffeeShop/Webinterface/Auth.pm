package CoffeeShop::Webinterface::Auth;
use strict;
use warnings FATAL => 'all';

use Dancer2 appname => 'CoffeeShop::Webinterface';

use CoffeeShop::Administrators;

hook before => sub {
    if (!session('user') && request->path !~ m{^/login}) {
      forward '/login', { requested_path => request->path };
    }
  };


get '/logout' => sub {
    app->destroy_session;
    redirect('/login');
  };

get '/login' => sub {
    
    #    return Dumper(session);
    my %TEMPLATE_PARAMS = ( REDIRECT_URL => query_parameters->get('requested_path')  );
    
    if(query_parameters->{'failed'}){
      $TEMPLATE_PARAMS{FAILED} = 'Login not found';
      
    }
    
    template login => \%TEMPLATE_PARAMS;
  };

post '/login' => sub {
    my $username  = body_parameters->get('username');
    my $redir_url = body_parameters->get('redirect_url') || '/';
    
    my $admin = CoffeeShop::Administrators::get_by_login($username);
    
    if($admin){
      session user => $username;
      redirect $redir_url;
    }
    else{
      redirect '/login?failed=1';
    }
  };

1;