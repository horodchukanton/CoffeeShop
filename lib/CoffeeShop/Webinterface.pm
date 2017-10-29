package CoffeeShop::Webinterface;
use strict;
use warnings FATAL => 'all';


use Dancer2;
use CoffeeShop::DB qw/resultset/;

set 'appdir' => '/usr/bukinist/lib/CoffeeShop/Webinterface';
set 'views'  => config->{appdir} . "/views/";
set 'layout' => 'main';
set 'template' => 'TemplateToolkit';

get '/' => sub {
    session('user')
      or redirect('/login');
    
    template index => {};
  };

get '/login' => sub {
#    use Data::Dumper;
#    return Dumper(config);
    my %TEMPLATE_PARAMS = ();
    
    if(query_parameters->{'failed'}){
      $TEMPLATE_PARAMS{FAILED} = 'Login not found';
      
    }
    
    template login => \%TEMPLATE_PARAMS;
  };

post '/login' => sub {
    
    use Dancer2::Serializer::Dumper;
    Dancer2::Serializer::Dumper->serialize(body_parameters);
    my $username  = body_parameters->get('username');
    my $redir_url = body_parameters->get('redirect_url') || '/login';
    
    my $Admin = resultset('Administrator');
    my $admin = $Admin->find({id => $username});
    
    if($admin){
      session user => $username;
      redirect $redir_url;
    }
    else{
      redirect '/login?failed=1';
    }
  };

1;