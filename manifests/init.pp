class newrelic( $enabled = 'true' ) {

  package { 'newrelic_rpm':
    ensure   => $enabled ? {
      'true'  => 'present',
      'false' => 'absent',
      default => 'absent',
    },
    provider => gem,
  }

}
