puppet-expiringexport
=====================

puppet-expiringexport is an defined resource type that wraps existing resources in an expiring container.

When the exporting node evaluates the resource, the parameters will evaluate in the context of the exporting node, setting the $timestamp parameter.  
When the collecting node evaluates the resource, the function will evaluate in the context of the collecting node, where it will compare the $timestamp parameter to the time now.  
If it's too old, the resource inside the container will not be created.

This is a (hacky) solution to the problem of exported resources not expiring in puppet. 

Usage
-----

      @@expiringexport {
        "bacula::director::custom_config-$hostname": 
          instances => { 
            "$hostname" => {
              content           => template('zylon/bacula/client_config.erb'),
            }
          };
      }


