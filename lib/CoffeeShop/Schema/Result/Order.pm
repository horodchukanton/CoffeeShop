use utf8;
package CoffeeShop::Schema::Result::Order;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CoffeeShop::Schema::Result::Order

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<orders>

=cut

__PACKAGE__->table("orders");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 customer_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 status_id

  data_type: 'smallint'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 creation_time

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 administrator_id

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_nullable: 0

=head2 total

  data_type: 'double precision'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "customer_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "status_id",
  {
    data_type => "smallint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "creation_time",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "administrator_id",
  { data_type => "smallint", extra => { unsigned => 1 }, is_nullable => 0 },
  "total",
  {
    data_type => "double precision",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 customer

Type: belongs_to

Related object: L<CoffeeShop::Schema::Result::Customer>

=cut

__PACKAGE__->belongs_to(
  "customer",
  "CoffeeShop::Schema::Result::Customer",
  { id => "customer_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 orders_good

Type: might_have

Related object: L<CoffeeShop::Schema::Result::OrdersGood>

=cut

__PACKAGE__->might_have(
  "orders_good",
  "CoffeeShop::Schema::Result::OrdersGood",
  { "foreign.order_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 status

Type: belongs_to

Related object: L<CoffeeShop::Schema::Result::Status>

=cut

__PACKAGE__->belongs_to(
  "status",
  "CoffeeShop::Schema::Result::Status",
  { id => "status_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-03 13:06:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OuQoyTEEFjf3v42JI7wRMg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
