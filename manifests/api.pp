class newrelic::api( $enabled = 'true' ) {

  package { 'newrelic_api':
    ensure   => $enabled ? {
      'true'  => 'present',
      'false' => 'absent',
      default => 'absent',
    },
    provider => gem,
  }

}
