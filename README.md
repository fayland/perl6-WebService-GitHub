# perl6-WebService-GitHub

[![Build Status](https://travis-ci.org/fayland/perl6-WebService-GitHub.svg?branch=master)](https://travis-ci.org/fayland/perl6-WebService-GitHub)

# SYNOPSIS

    use WebServices::GitHub;

    my $gh = WebServices::GitHub.new(
        access-token => 'my-access-token'
    );

    my $res = $gh.request('/user');
    say $res.data.name;

# Examples

