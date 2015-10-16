# perl6-WebService-GitHub

[![Build Status](https://travis-ci.org/fayland/perl6-WebService-GitHub.svg?branch=master)](https://travis-ci.org/fayland/perl6-WebService-GitHub)

*ALPHA STAGE, SUBJECT TO CHANGE*

# SYNOPSIS

    use WebServices::GitHub;

    my $gh = WebServices::GitHub.new(
        access-token => 'my-access-token'
    );

    my $res = $gh.request('/user');
    say $res.data.name;

# TODO

Patches welcome

 * Break down modules (Users, Repos, Issues etc.)
 * Errors Handle
 * Conditional requests
 * Auto Pagination
 * API Throttle

# Methods

## Args

### `endpoint`

useful for GitHub Enterprise. default to L<https://api.github.com>

### `access-token`

Required for Authorized API Request

### `auth_login` & `auth_password`

Basic Authenticaation. useful to get `access-token`.

### `per_page`

from [Doc](https://developer.github.com/v3/#pagination), default to 30, max to 100.

### `jsonp_callback`

[JSONP Callback](https://developer.github.com/v3/#json-p-callbacks)

### `time-zone`

UTC by default, [Doc](https://developer.github.com/v3/#timezones)

## Response

### `raw`

HTTP::Request instance

### `data`

JSON decoded data

### `header(Str $field)`

Get header of HTTP Response

### `first-page-url`, `prev-page-url`, `next-page-url`, `last-page-url`

Parsed from Link header, [Doc](https://developer.github.com/v3/#pagination)

### `x-ratelimit-limit`, `x-ratelimit-remaining`, `x-ratelimit-reset`

[Rate Limit](https://developer.github.com/v3/#rate-limiting)

# Examples

## Public Access without access-token

### get user info

    my $gh = WebServices::GitHub.new;
    my $user = $gh.request('/users/fayland').data;
    say $user<name>;

