use utf8;
package CoffeeShop::Schema::Result::StoresAccounting;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CoffeeShop::Schema::Result::StoresAccounting - All stores accounting

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<stores_accounting>

=cut

__PACKAGE__->table("stores_accounting");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 date

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 administrator_id

  data_type: 'smallint'
  is_nullable: 1

=head2 vendor_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 store_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 item_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_nullable: 1

=head2 units

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_nullable: 0

=head2 sum_per_unit

  data_type: 'double precision'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=head2 operation_type

  data_type: 'tinyint'
  default_value: 0
  extra: {unsigned => 1}
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
  "date",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "administrator_id",
  { data_type => "smallint", is_nullable => 1 },
  "vendor_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "store_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "item_id",
  { data_type => "integer", extra => { unsigned => 1 }, is_nullable => 1 },
  "units",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
  "sum_per_unit",
  {
    data_type => "double precision",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
  "operation_type",
  {
    data_type => "tinyint",
    default_value => 0,
    extra => { unsigned => 1 },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-12-25 15:09:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rmfsaXMHSa315VRR75qINw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
