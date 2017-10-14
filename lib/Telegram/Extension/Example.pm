package Telegram::Extension::Example;
use strict;
use warnings FATAL => 'all';

=head2 NAME

  Telegram::Extension::Example
  
=head2 SYNOPSIS

  Example extension for ABillS Telegram bot.
  Copy it to Extension/Custom_%YOUR_EXTENSION_NAME%.pm to prevent it from erasing on update,
  and add to $conf{TELEGRAM_LOAD_EXTENSIONS} = 'Custom_%YOUR_EXTENSION_NAME%, Custom_%YOUR_ANOTHER_EXTENSION_NAME%.pm';
  
  You can change anything between this #cccccccccccccccccccccccccc# lines as long as it is correct perl code.
  
  By default you should just define a command and a coderef to call when text was received
  You also can redeclare 'default' callback to receive all messages without callback defined
  
  Each callback recieves this arguments:
    $message - perl structure (hash_ref) for Telegram API Message object (https://core.telegram.org/bots/api#message)
    $chat_id - is id for client who has send the message
    $client_type - can be AID or UID. dependens on how client has been registered.
     If person has contact for both admin and user account, User privileges are used.
    $client_id   - id of person's account in ABillS (uid for client  and  aid for admin)

  
=cut

our ($db, $admin, %conf, $base_dir);

use Log;

use Telegram;
use Telegram::Extension;
use parent 'Telegram::Extension';

#cccccccccccccccccccccccccc#
# you SHOULD change this
my $EXTENSION = 'Example';

# you CAN Delete this if you don't want ( and will not ) use $Log
# Logging levels defined by $conf{TELEGRAM_EXTENSIONS_DEBUG} or $conf{TELEGRAM_EXTENSION_%EXTENSION%_DEBUG} variables
my Log $Log =
  Telegram::Extension::build_log_for(
    $EXTENSION,
    '/usr/abills/var/log/telegram_example.log'
  );
#cccccccccccccccccccccccccc#


#**********************************************************
=head2 add_extensions()

=cut
#**********************************************************
sub add_extensions {
  my Telegram $Telegram_Bot = shift;
  
  #cccccccccccccccccccccccccc#
  $Telegram_Bot->add_callback('/help', sub {
      my ($message, $chat_id, $client_type, $client_id) = @_;
      $Log->info("$client_type #$client_id requested for /help. Ha-ha");
      $Telegram_Bot->send_text("No help for you now, $client_type #$client_id", $chat_id);
  });
  
  $Telegram_Bot->add_callback('/echo', sub {
      my ($message, $chat_id, $client_type, $client_id) = @_;
      
      my $message_data = '';
      if ($message->{text} =~ /^\/echo (.*)$/){
        $message_data = $1 || '';
      }
      else {
        $message_data = 'Empty data. Specify a string after "/echo". For example "/echo hello"';
      };
      
      $Telegram_Bot->send_text($message_data, $chat_id);
    });
  #cccccccccccccccccccccccccc#
  
  return 1;
}

1;