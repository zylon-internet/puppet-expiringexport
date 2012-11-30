# Based on example: https://github.com/jordansissel/puppet-examples/blob/master/exported-expiration/modules/example/manifests/expiringhost.pp

define expiringexport (
$instances = {},
$timestamp = inline_template("<%= Time.now.strftime('%Y-%m-%dT%H:%M:%S%z') %>") 
) {

  $namesplit = split($name, '-')
  $resource = $namesplit[0]

  # Calculate the age of this resource by comparing 'now' against $timestamp
  $age = inline_template("<%= require 'time'; Time.now - Time.parse(timestamp) %>")

  # Max age, in seconds.
  $maxage = 14400 

  if $age > $maxage {
    $expired = true
    #notice("Expiring resource $class[$name] due to age > $maxage (actual: $age)")
  } else {
    $expired = false
    #notice("Found recently-active $class[$name] (age: $age)")
  }

  if $expired == false {
    create_resources($resource, $instances)
  }
}

