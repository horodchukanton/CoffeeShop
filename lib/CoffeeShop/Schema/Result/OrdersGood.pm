use utf8;
package CoffeeShop::Schema::Result::OrdersGood;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CoffeeShop::Schema::Result::OrdersGood

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<orders_goods>

=cut

__PACKAGE__->table("orders_goods");

=head1 ACCESSORS

=head2 order_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 good_id

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "order_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "good_id",
  {
    data_type => "smallint",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</order_id>

=back

=cut

__PACKAGE__->set_primary_key("order_id");

=head1 RELATIONS

=head2 good

Type: belongs_to

Related object: L<CoffeeShop::Schema::Result::Good>

=cut

__PACKAGE__->belongs_to(
  "good",
  "CoffeeShop::Schema::Result::Good",
  { id => "good_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 order

Type: belongs_to

Related object: L<CoffeeShop::Schema::Result::Order>

=cut

__PACKAGE__->belongs_to(
  "order",
  "CoffeeShop::Schema::Result::Order",
  { id => "order_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-03 13:06:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Qj+97fvh05NSIW+YYOzF4A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
