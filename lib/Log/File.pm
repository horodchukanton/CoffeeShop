package Log::File;
use strict;
use warnings FATAL => 'all';

use AnyEvent;
use AnyEvent::Handle;

use Log qw/:levels/;

my %file_handles = ();
#**********************************************************
=head2 new($file_qualifier, $current_level, $attr)

  Arguments:
    $file_qualifier
    $current_level
    $attr
    
  Returns:
    object
    
=cut
#**********************************************************
sub new {
  my $class = shift;
  
  my ($file_qualifier) = @_;
  
  $file_qualifier //= \*STDOUT;
  
  my $self = {
    file => $file_qualifier,
  };
  
  bless($self, $class);
  
  return $self;
}

#**********************************************************
=head2 log($time, $label, $level, $message)

  Arguments:
    $level, $label, $message -
    
  Returns:
  
=cut
#**********************************************************
sub log {
  my ($self, $time, $label, $level, $message) = @_;
  
  my $hdl = _get_handle_for_file($self->{file});
  
  # Construct message
  $hdl->push_write("[$time] [ $label\t] $Log::STR_LEVEL{$level} : $message\n");
}



#**********************************************************
=head2 _get_handle_for_file($file_name) -

  Arguments:
    $file_name -
    
  Returns:
  
  
=cut
#**********************************************************
#@returns AnyEvent::Handle
sub _get_handle_for_file {
  my ($file_name) = @_;
  
  if ( !exists $file_handles{$file_name} || $file_handles{$file_name}->destroyed() ) {
    
    my $log_fh;
    if ( !ref $file_name ) {
      open ($log_fh, '>>', $file_name) or die "Can't open $file_name : $@";
    }
    elsif ( ref $file_name eq 'GLOB' ) {
      $log_fh = $file_name
    }
    
    my AnyEvent::Handle $handle = AnyEvent::Handle->new(
      fh       => $log_fh,
      linger   => 1, # Allow write last data on destroy,
      on_error => sub {
        print "Error on log ";
      }
    );
    
    $file_handles{$file_name} = $handle;
  }
  
  return $file_handles{$file_name};
}

1;