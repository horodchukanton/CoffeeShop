use utf8;
package CoffeeShop::Schema::Result::Good;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CoffeeShop::Schema::Result::Good

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<goods>

=cut

__PACKAGE__->table("goods");

=head1 ACCESSORS

=head2 id

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 price

  data_type: 'double precision'
  default_value: 0.00
  is_nullable: 0
  size: [10,2]

=head2 time_to_make

  data_type: 'smallint'
  default_value: 60
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type => "smallint",
    extra => { unsigned => 1 },
    is_auto_increment => 1,
    is_nullable => 0,
  },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "price",
  {
    data_type => "double precision",
    default_value => "0.00",
    is_nullable => 0,
    size => [10, 2],
  },
  "time_to_make",
  { data_type => "smallint", default_value => 60, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 orders_goods

Type: has_many

Related object: L<CoffeeShop::Schema::Result::OrdersGood>

=cut

__PACKAGE__->has_many(
  "orders_goods",
  "CoffeeShop::Schema::Result::OrdersGood",
  { "foreign.good_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-03 13:06:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SsdbclwaAbm0vNC3qCrmJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
