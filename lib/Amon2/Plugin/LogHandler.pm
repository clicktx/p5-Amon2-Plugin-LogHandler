package Amon2::Plugin::LogHandler;
use 5.008001;
use strict;
use warnings;

our $VERSION = "0.01";

use Log::Handler;
use Amon2::Util ();

sub init {
    my ( $class, $c, $config ) = @_;

    my $conf = $c->config->{'Log::Handler'}
      || die
"missing configuration for LogHandler plugin(\$c->{'Log::Handler'} is undefined)";
    my $logger = Log::Handler->new();

    if ( $ENV{PLACK_ENV} && $ENV{PLACK_ENV} eq 'production' ) {
        delete $conf->{screen};
        delete $conf->{file}->{'debug'};
    }
    $logger->config( config => $conf ) or die $logger->errstr;
    Amon2::Util::add_method(
        $c, 'log',
        sub {
            $SIG{__WARN__} = sub { $logger->log( warn => @_ ) };
            $SIG{__DIE__} = sub { $logger->trace( emergency => @_ ) };
            $logger;
        },
    );
    Amon2::Util::add_method(
        $c, 'debug',
        sub { shift->log->debug(shift) },
    );
}

1;
__END__

=encoding utf-8

=head1 NAME

Amon2::Plugin::LogHandler - It's new $module

=head1 SYNOPSIS

    use Amon2::Plugin::LogHandler;

=head1 DESCRIPTION

Amon2::Plugin::LogHandler is ...

=head1 LICENSE

Copyright (C) clicktx.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

clicktx E<lt>clicktx@gmail.comE<gt>

=cut
