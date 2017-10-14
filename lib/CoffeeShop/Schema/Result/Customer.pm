use utf8;
package CoffeeShop::Schema::Result::Customer;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CoffeeShop::Schema::Result::Customer

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<customers>

=cut

__PACKAGE__->table("customers");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 account

  data_type: 'double precision'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=head2 chat_id

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 registration_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "account",
  {
    data_type => "double precision",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
  "chat_id",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "registration_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<chat_id>

=over 4

=item * L</chat_id>

=back

=cut

__PACKAGE__->add_unique_constraint("chat_id", ["chat_id"]);

=head1 RELATIONS

=head2 orders

Type: has_many

Related object: L<CoffeeShop::Schema::Result::Order>

=cut

__PACKAGE__->has_many(
  "orders",
  "CoffeeShop::Schema::Result::Order",
  { "foreign.customer_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-03 14:46:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:t2tpjrxN7TA33L5W5galYw


#**********************************************************
=head2 set_account($account) -

  Arguments:
     -
    
  Returns:
  
  
=cut
#**********************************************************
sub set_account {
  my ($self, $new_account ) = @_;
  
  # Update object
  $self->account($new_account);
  
  # Update DB row
  $self->update({account => $new_account});
  
  return $new_account;
}
1;
