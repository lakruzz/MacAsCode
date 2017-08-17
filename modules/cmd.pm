package cmd;

require 5.001;
require Exporter;
use strict;
use Carp;                  # http://perldoc.perl.org/Carp.html


our @ISA    = qw(Exporter);
our @EXPORT = qw(new);        #Export only the constructor

sub new {
    my $class = shift;    #Cache the package name
    my $self = {};
    bless( $self, $class );
    return $self;
}

sub exec($) {
  my $self = shift;

  my %opt = @_;
  croak "input parameter for key 'command' required" unless ( $opt{command} );
  defined( $opt{die_on_err} )   ||  do {$opt{die_on_err}   = 1};
  defined( $opt{system} )       ||  do {$opt{system}       = 0};
	defined( $opt{merge_errout} ) ||  do {$opt{merge_errout} = 1};
	defined( $opt{verbose} )      ||  do {$opt{verbose}      = 0};
	defined( $opt{return_array} ) ||  do {$opt{return_array} = 0};
  my $cmd = ($opt{merge_errout})? $opt{command} . ' 2>&1' : $opt{command};
	$opt{verbose} && print $opt{command}."\n";
  my @res;
  if ($opt{system}){
    system($cmd);
  } else {
    @res= qx($cmd);
  };
  # Report errors unless we expect the call to generate non-zero exit value
  unless ( not $opt{die_on_err} ) {
    if ($?) {
      croak "Execution of [$cmd] returned a non-zero value (".( ($?) / 256).")\n";
    }
  };
  return ( $opt{return_array} ) ? @res : join( '', @res );
}

=pod

=head1 NAME

B<cmd.pm>

A module that executes system commands

=head1 SYNOPSIS

To enable locally stored module (E.g in C<./modules> relative to the
executing script) add the following:

  use Cwd;
  use File::Basename;
  my ($filename,$path,$suffix) = fileparse(Cwd::abs_path($0));
  use lib "$path..";
  use modules::cmd

When module is succesfully included as above use it like this:

  our $cmd = cmd->new();
  $cmd->exec(command => "git pull");

Or to continue on error and type each command to STDOUT before it's executed do

  $cmd->exec(command    => "git pull",
             die_on_err => 0,
             verbose    => 1);

=head1 OPTIONS

The following options are available - only C<command> is required - all others
have default values.

  $cmd->exec(
    command => "git pull",  # Some system command to execute
    die_on_err   => 1,      # Wether to die or continue on err
    system       => 0,      # Wether to use system() or qx() for excution
    merge_errout => 1,      # Wether to merge ERROUT into STDOUR or keem them seperate
    verbose      => 0,      # Wether to type command to STDOUT before execution or not
    return_array => 0       # Wether to return STDOUT as an array or a string
  );

The values shown above are the default values.

=head1 DESCRIPTION


B<Copyright>

L<Lars Kruse, 2017|http://github.com/lakruzz>

B<License>

L<GPLv3|https://www.gnu.org/licenses/gpl-3.0.en.html>

B<Repository>

L<lakruzz/MacAsCode|http://github.com/lakruzz/MacAsCode>

B<Support>

L<Use the issue system|http://github.com/lakruzz/MacAsCode/issues> in the repo.

=cut
