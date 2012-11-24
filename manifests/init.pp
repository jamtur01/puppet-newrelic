class newrelic( $enabled = 'true' ) {

  package { [ 'newrelic_rpm', 'newrelic_api' ]:
    ensure   => $enabled ? {
      'true'  => 'present',
      'false' => 'absent',
      default => 'absent',
    },
    provider => gem,
  }

}
