use utf8;
package CoffeeShop::Schema::Result::Store;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CoffeeShop::Schema::Result::Store - Table for stores

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<stores>

=cut

__PACKAGE__->table("stores");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  default_value: (empty string)
  is_nullable: 0
  size: 50

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
  { data_type => "varchar", default_value => "", is_nullable => 0, size => 50 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-12-25 15:09:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2M0c9321im7Up8SzyauOfQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
