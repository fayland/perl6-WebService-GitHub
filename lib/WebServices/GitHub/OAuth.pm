use v6;

use WebServices::GitHub::Role;

class WebServices::GitHub::OAuth does WebServices::GitHub::Role {
    method authorizations {
        self.request('/authorizations')
    }

    method authorization($id) {
        self.request('/authorizations/' ~ $id);
    }

    method create_authorization(%data) {
        self.request(:path</authorizations>, :methed<POST>, :data(%data));
    }

    method create_app_authorization($client_id, %data, :$fingerprint) {
        my $url = '/authorizations/clients/' ~ $client_id;
        $url = $url ~ '/' ~ $fingerprint if $fingerprint.defined;
        self.request(:path($url), :methed<PUT>, :data(%data));
    }

    method update_authorization($id, %data) {
        self.request(:path('/authorizations/' ~ $id), :methed<PATCH>, :data(%data));
    }

    method delete_authorization($id) {
        self.request(:path('/authorizations/' ~ $id), :methed<DELETE>);
    }
}