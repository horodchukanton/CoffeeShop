use utf8;
package CoffeeShop::Schema::Result::Administrator;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CoffeeShop::Schema::Result::Administrator

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<administrators>

=cut

__PACKAGE__->table("administrators");

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

=head2 chat_id

  data_type: 'varchar'
  is_nullable: 0
  size: 128

=head2 role_id

  data_type: 'smallint'
  default_value: 1
  extra: {unsigned => 1}
  is_foreign_key: 1
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
  "chat_id",
  { data_type => "varchar", is_nullable => 0, size => 128 },
  "role_id",
  {
    data_type => "smallint",
    default_value => 1,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 role

Type: belongs_to

Related object: L<CoffeeShop::Schema::Result::AdministratorRole>

=cut

__PACKAGE__->belongs_to(
  "role",
  "CoffeeShop::Schema::Result::AdministratorRole",
  { id => "role_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-03 13:06:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uWh8L9URUxsOmfx6e20KZg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
