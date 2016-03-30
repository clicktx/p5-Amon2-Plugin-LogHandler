# NAME

Amon2::Plugin::LogHandler - Log::Handler glue for Amon2

# SYNOPSIS
    # in your App
    __PACKAGE__->load_plugin('LogHandler');

    # in your config.pl
    my $basedir =
      File::Spec->rel2abs( File::Spec->catdir( dirname(__FILE__), '..' ) );
    my $log_dir = File::Spec->catdir( $basedir, 'var', 'log' );

    'Log::Handler' => {
        screen => {
            log_to   => "STDOUT",
            maxlevel => "debug",
            minlevel => "emergency",
        },
        file => {
            default => {
                mode => "append",
            },
            debug => {
                filename => [ $log_dir, "debug.log" ],
                maxlevel => "debug",
                minlevel => "emergency",
            },
            common => {
                filename => [ $log_dir, "common.log" ],
                maxlevel => "info",
                minlevel => "warn",
            },
            error => {
                filename => [ $log_dir, "error.log" ],
                maxlevel => "warn",
                minlevel => "emergency",
            },
        },
    },

    # in your controller
    $c->log->info('message info');
    $c->debug('debug message'); #debug is alies

    # your log files
    % tailf MyApp/var/log/debug.log
    % tailf MyApp/var/log/common.log
    % tailf MyApp/var/log/error.log

# DESCRIPTION

Amon2::Plugin::LogHandler is glue for [Amon2](https://metacpan.org/pod/Amon2). This module is [Amon2::Plugin::LogDispach](https://metacpan.org/pod/Amon2::Plugin::LogDispach) forked product.

# SEE ALSO

[Amon2](https://metacpan.org/pod/Amon2) [Log::Handler](https://metacpan.org/pod/Log::Handler)

# LICENSE

Copyright (C) clicktx.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

clicktx <clicktx@gmail.com>
