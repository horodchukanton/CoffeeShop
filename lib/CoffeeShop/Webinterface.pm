package CoffeeShop::Webinterface;
use strict;
use warnings FATAL => 'all';


use Dancer2;
use CoffeeShop::Webinterface::Auth;
use Data::Dumper;

use CoffeeShop::Administrators;

set 'appdir' => '/usr/CoffeeShop/lib/CoffeeShop/Webinterface';
set 'views'  => config->{appdir} . "/views/";
set 'layout' => 'main';
set 'template' => 'TemplateToolkit';
set 'session'  => 'YAML';

get '/' => sub {
    session('user')
      or redirect('/login');
    
    template index => {};
  };

get '/admins' => sub {
    
    my @admins_list= CoffeeShop::Administrators::get_all();
    my $return = '';
    foreach my $admin (@admins_list){
      $return .= $admin->name();
    }
    return $return
  };

1;