use v6;

role WebServices::GitHub::Role::Debug {
    method prepare_request($request) {
        say $request.perl;
        return $request;
    }
    method handle_response($response) {
        say $response.perl;
        return $response
    }
}