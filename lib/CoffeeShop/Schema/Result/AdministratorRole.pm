use utf8;
package CoffeeShop::Schema::Result::AdministratorRole;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

CoffeeShop::Schema::Result::AdministratorRole

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<administrator_roles>

=cut

__PACKAGE__->table("administrator_roles");

=head1 ACCESSORS

=head2 id

  data_type: 'smallint'
  extra: {unsigned => 1}
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 32

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
  { data_type => "varchar", is_nullable => 0, size => 32 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 administrators

Type: has_many

Related object: L<CoffeeShop::Schema::Result::Administrator>

=cut

__PACKAGE__->has_many(
  "administrators",
  "CoffeeShop::Schema::Result::Administrator",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2017-09-03 13:06:27
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MD0ykoYrRhIf/eRiaYWM/A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
