package App::TextFragmentUtils;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Data::Clone;
use File::Slurper qw(read_text);
use Text::Fragment ();

our %SPEC;

my $filename_arg = {
    schema => 'filename*',
    req => 1,
    pos => 0,
    cmdline_aliases => {f=>{}},
};

sub _get_tf_args {
    my %args = @_;

    my %tf_args = %args;
    my $filename = delete $tf_args{filename};
    my $text;
    if ($filename eq '-') {
        local $/;
        $text = <STDIN>;
    } else {
        $text = read_text($filename);
    }
    $tf_args{text} = $text;
    \%tf_args;
}

$SPEC{list_fragments} = do {
    my $meta = clone $Text::Fragment::SPEC{list_fragments};
    delete $meta->{args}{text};
    $meta->{args}{filename} = $filename_arg,
    $meta;
};
sub list_fragments {
    my %args = @_;

    my $tf_args = _get_tf_args(%args);
    Text::Fragment::list_fragments(%$tf_args);
}

$SPEC{get_fragment} = do {
    my $meta = clone $Text::Fragment::SPEC{get_fragment};
    delete $meta->{args}{text};
    $meta->{args}{filename} = $filename_arg,
    $meta;
};
sub get_fragment {
    my %args = @_;

    my $tf_args = _get_tf_args(%args);
    Text::Fragment::get_fragment(%$tf_args);
}

1;
#ABSTRACT: CLI utilities related to Text::Fragment

=head1 DESCRIPTION

This distributions provides the following command-line utilities related to
text fragment:

# INSERT_EXECS_LIST


=head1 SEE ALSO

L<Text::Fragment>
