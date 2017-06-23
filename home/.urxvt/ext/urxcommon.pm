# @ref: common (c) amerlyq, 2015: GPLv3
# @brief: common parts of extensions -- don't run as standalone!
package urxcommon;

# =================== Package ========================
use warnings;
use strict;
no strict 'subs';  # because 'urxvt::*' can't be imported
use Exporter;
use Data::Dump qw(dump);  # NEED libdata-dump-perl
# use List::Util qw(reduce);
# NEED apt-get install liblist-moreutils-perl
# use List::MoreUtils qw{
#     any all none notall true false
#     firstidx first_index lastidx last_index
#     insert_after insert_after_string
#     apply indexes
#     after after_incl before before_incl
#     firstval first_value lastval last_value
#     each_array each_arrayref
#     pairwise natatime
#     mesh zip uniq distinct minmax part
# };

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK %EXPORT_TAGS);
$VERSION     = 1.00;
@ISA         = qw(Exporter);
@EXPORT      = ();  # Always export
@EXPORT_OK   = qw(err_cmd err_run line_count text_metrics
                  sxdef bxdef paired matches hashcurry fmt_key);  # On demand
%EXPORT_TAGS = (API => [qw(&err_cmd &err_run &line_count &text_metrics
                        &sxdef &bxdef &paired &matches &hashcurry &fmt_key)]);


# =================== Embed ========================
sub err_cmd { warn "unknown command '$_[0]'\n"; () }
sub err_run { warn "error running: '$_[0]': $!\n"; () }

# =================== Shorts ========================
# SEE https://github.com/perl5-utils/List-MoreUtils/blob/master/lib/List/MoreUtils/PP.pm
sub matches { my ($t,$r,@v)=@_;
    while ($t =~ /$r/g) { push @v, [$-[0], $+[0]]; }; return @v }
sub line_count { scalar(split('\n', $_[0])); }
sub text_metrics { sprintf("%dL> %-d", line_count($_[0]), length($_[0])); }

# sub mapby2 {
# sub maps (& \@ \@) {
#     my ($code_ref, $a_ref, $b_ref) = @_; my @rv;
#     my $rv_len = (@$a_ref < @$b_ref) ? @$a_ref : @$b_ref;
#     for ( my $i = 0; $i < $rv_len; ++$i ) {
#         local ( $a, $b ) = ( $a_ref->[$i], $b_ref->[$i] );
#         push @rv, $code_ref->();
#     }
#     return @rv;
# }

# sub python_zip(\@\@;\@\@\@) { # Add more \@ to taste
#    my $short = min(map(scalar(@$_), @_));
#    return &zip(map(@$_ == $short ? $_ : [@$_[0..$short-1]], @_));
# }
# sub zip { (@a, @b)[ map { $_, $_ + @a } 0 .. $#a ] }
# map { $_->[0] => staying("pt/$_->[1]") } zip(qw(L W P U), keys %{$self->{patterns}};
# OR zip { my $max = -1; $max < $#$_  &&  ($max = $#$_)  for @_;
#           map { my $ix = $_; map $_->[$ix], @_; } 0..$max; }


# Wrapper for action tuples: curry (args bind) impl by closure
sub paired { my $val = pop @_; map { $_=> $val } @_ }
sub hashcurry {
    my ($hmap, @nms) = @_;
    my @funs = map { $hmap->{$_} if $_ } @nms;
    # { local $,=" "; print "S:",@nms,":",@funs,"\n"; }
    return sub { $_->(@_) foreach @funs; }
    # ALT return eval "sub {". map { "$_" . '->(@_);' } @funs ."}"; }
}

# =================== Convertors ========================

sub sxdef {
    # { local $,=" "; print @_, "\n"; }
    my ($term, $dfv) = (shift, pop);
    $_[-1] => $term->x_resource(join ".", "%", @_) // $dfv
}
sub bxdef {
    # { local $,=" "; print @_, "\n"; }
    # my $term = shift;
    # my $dfv = pop;
    my ($term, $dfv) = (shift, pop);
    $_[-1] => map {$dfv if $_ eq ""}
        $term->x_resource_boolean(join ".", "%", @_)
}

# Input events
sub fmt_key {
    my ($term, $event, $keysym) = @_;
    my ($mod, $e) = ('', $event->{state});
    # if (0x20 <= $keysym && $keysym < 0x80) {
    $mod .= 'A-' if ($e & $term->ModLevel3Mask);
    $mod .= 'M-' if ($e & $term->ModMetaMask);
    $mod .= 'C-' if ($e & urxvt::ControlMask);
    $mod .= 'S-' if ($e & urxvt::ShiftMask);

    my $key = $term->XKeysymToString($keysym);
    if (1 == length($key)) {
        if ('S-' eq $mod) { return $key; }
        else { $key = lc $key; }
    }
    return $mod . $key;
}
