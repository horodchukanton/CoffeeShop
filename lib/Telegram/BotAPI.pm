package Telegram::BotAPI;
use strict;
use warnings 'FATAL' => 'all';
=head1 NAME
  
  Telegram::BotAPI - Interface to Telegram Bot API
  
=cut

use AnyEvent;
use AnyEvent::Handle;
use AnyEvent::Socket;
use JSON;

my JSON $json = JSON->new->utf8(0)->allow_nonref(1);

use Log;
my Log $Log;

#**********************************************************
=head2 AUTOLOAD()

=cut
#**********************************************************
sub AUTOLOAD {
  our ($AUTOLOAD);
  my $name = $AUTOLOAD;
  return if ( $name =~ /^.*::[A-Z]+$/ );
  
  my $self = shift;
  $name =~ s/^.*:://;   # strip fully-qualified portion
  
  my $res = 0;
  eval {
    $res = $self->make_request($name, @_);
  };
  return $res;
}

#**********************************************************
=head2 new($attr)

  Arguments:
    $attr -
      token   - auth token
      api_host - (optional), where to send requests. Default is 'api.telegram.org'
      debug   - debug level
      
  Returns:
    Telegram::BotAPI instance
  
=cut
#**********************************************************
sub new {
  my $class = shift;
  my ($conf, $attr) = @_;
  
  die "No token" unless ( $attr->{token} );
  
  my $self = {
    token    => $attr->{token} || $conf->{TELEGRAM_TOKEN},
    api_host => $attr->{api_url} || 'api.telegram.org',
    debug    => $attr->{debug} || $conf->{TELEGRAM_API_DEBUG} || 0
  };
  
  $Log = Log->new('FILE', $self->{debug}, 'Telegram API', { FILE => $conf->{TELEGRAM_API_DEBUG_FILE} });
  
  bless($self, $class);
}

#**********************************************************
=head2 connect() - opens connection to Telegram API

=cut
#**********************************************************
sub connect {
  my ( $self, $callback ) = @_;
  
  my $endpoint = $self->{api_host};
  
  my $waiter = undef;
  if ( !$callback ) {
    $waiter = AnyEvent->condvar;
  }
  
  $self->{connection} = tcp_connect ($endpoint, 443,
    sub {
      my ($fh) = @_ or die "unable to connect: $!";
      
      my $handle; # avoid direct assignment so on_eof has it in scope.
      $handle = AnyEvent::Handle->new(
        fh        => $fh,
        tls       => 'connect',
        #        no_delay => 1,
        keepalive => 1,
        tls_ctx   => {
          sslv3          => 0,
          verify         => 1,
          session_ticket => 1,
        },
        on_error  => sub {
          my (undef, undef, $msg) = @_;
          $_[0]->destroy;
          delete $self->{handle};
          
          $Log->error('connect :' . $msg);
          
          if ( !$callback ) {
            $waiter->send(0);
          }
          else {
            $callback->(0);
          }
        }
      );
      
      $self->{handle} = $handle;
      
      if ( !$callback ) {
        $waiter->send(1);
        return 1;
      }
      
      $callback->(1);
    });
  
  if ( !$callback ) {
    my $connected = $waiter->recv;
    return $connected;
  }
}

#**********************************************************
=head2 make_request($method_name, $params, $callback) - async request

  Arguments:
    $method_name  - API method
    $params       - hash_ref
    $callback     - coderef, if given,
    
  Returns:
  
  
=cut
#**********************************************************
sub make_request {
  my $self = shift;
  my ($method_name, $params, $callback) = @_;
  
  # Prepare payload
  my $params_encoded = '';
  eval {
    $params_encoded = $json->encode($params);
  };
  if ( $@ ) {
    $Log->alert('REQUEST PARAMS ERROR : ' . $@);
    $Log->alert('REQUEST PARAMS ERROR : ' . $params);
    
    my $res = { error => $@, ok => 0, type => 'on_write' };
    if ( !$callback ) {
      return $res;
    }
    else {
      $callback->($res);
    }
  }
  
  my AnyEvent::Handle $handle = $self->{handle};
  if ( !$handle || $handle->destroyed() ) {
    $self->connect();
  }
  
  my $waiter;
  if ( !$callback ) {
    $waiter = AnyEvent->condvar();
  }
  
  $handle->on_error(sub {
    $handle->destroy();
    delete $self->{handle};
    
    $Log->error("Error sending request");
    
    $Log->error('TELEGRAM SEND ERROR : ' . ($_[2] || ''));
    
    if ( $waiter ) {
      $waiter->send(0);
    }
    else {
      return 0;
    }
  });
  
  $handle->on_eof(sub {
    $handle->destroy();
    delete $self->{handle};
    if ( $waiter ) {
      $waiter->send(0);
    }
    else {
      return 0;
    }
  });
  
  $handle->on_read(sub {
    my AnyEvent::Handle $hdl = shift;
    my $raw_content = $hdl->{rbuf};
    
    my (undef, $json_content) = split(/[\r\n]{4}/m, $raw_content);
    
    my $response = '';
    eval {
      $response = $json->decode($json_content);
    };
    if ( $@ ) {
      my %res = (error => $@, ok => 0, type => 'on_read');
      if ( !$callback ) {return \%res;}
      else {$callback->(\%res);}
    }
    $hdl->{rbuf} = '';
    
    $Log->debug($response);
    
    if ( !$response->{ok} ) {
      if ( $response->{error_code} && $response->{description} ) {
        $Log->warning(
          $response->{error_code} . ' : ' . $response->{description} || 'Unknown error');
      }
    }
    
    if ( !$callback ) {
      $waiter->send($response);
    }
    else {
      $callback->($response);
    }
  });
  
  my $length = length $params_encoded;
  $handle->push_write(qq{GET /bot$self->{token}/$method_name HTTP/1.1
Host: $self->{api_host}
Pragma: no-cache
Cache-Control: no-cache
Content-Length: $length
Connection: keep-alive
Content-Type: application/json; charset=utf-8

$params_encoded});
  
  if ( !$callback ) {
    return $waiter->recv();
  }
  return 1;
}

sub DESTROY {

}

1;