package Telegram::ModuleInterface;
use strict;
use warnings FATAL => 'all';

=head2 NAME

  Telegram::ModuleInterface
  
=cut

# Msgs. will generify later

our (%conf, $base_dir);

use Telegram::Operation;

#**********************************************************
=head2 process_data()
  
  Arguments:
    $api      - API for Telegram plugin
    $data_raw - data as got from callback_query
    $attr     - hash_ref
      SENDER - hash_ref
        CHAT_ID - chat_id
        TYPE    - string, 'AID' or 'UID'
  
  Returns:
    0 on error
    instance of Telegram::Operation
    
=cut
#**********************************************************
sub process_data {
  my Telegram $api = shift;
  
  my ($data_arr, $attr) = @_;
  return if ( !$attr->{CHAT_ID} || !$data_arr );
  
  # Parse data
  my @data = ();
  if ( ref $data_arr eq 'ARRAY' ) {
    @data = @{$data_arr};
  }
  else {
    @data = split(':', $data_arr);
  }
  
  my $method = shift @data;
  
  my $client_type = $attr->{CLIENT_TYPE};
  my $client_id = $attr->{CLIENT_ID};
  
  if ( $method && $method eq 'REPLY' ) {
    my $msg_id = shift @data;
    my $callback_id = $attr->{callback_query_id};
    my $chat_id = $attr->{CHAT_ID};
    
    if ( !$msg_id ) {
      $api->send_callback_answer($attr->{callback_query_id}, "No msg id");
      return 0;
    }
    
    # Create new operation
    my $reply_operation = Telegram::Operation->new({
      NAME       => 'Reply',
      MSGS_ID    => $msg_id,
      ON_START   => sub {
        #        $api->send_callback_answer($attr->{callback_query_id}, "Operation started");
        $api->send_text('_{TYPE_YOUR_RESPONSE}_', $chat_id);
        #        $api->send_callback_answer($callback_id, "_{TYPE_YOUR_RESPONSE}_");
      },
      ON_MESSAGE => sub {
        my ($self, $message) = @_;
        if (!$message->{text}){
          $api->send_text('_{TEXT_NOT_FOUND}_. _{TRY_AGAIN}_', $chat_id);
          return 0;
        }
        
        my $saved = 1;
        
        if (!$saved){
          my $err = '_{UNKNOWN_ERROR}_';
          $api->send_text("$err . _{TRY_AGAIN}_ or use '/cancel' to stop reply", $chat_id);
          0;
        }
        else {
          $api->send_text('_{SENDED}_', $chat_id);
          1;
        }
        
      },
      ON_FINISH  => sub {
        $api->send_callback_answer($callback_id, '_{SENDED}_');
      },
      %{ $attr },
      
    });
    
    return $reply_operation;
  }
  
  return 0;
}

1;