# vim: ft=sls

{#-
    Starts the monica, db container services
    and enables them at boot time.
    Has a dependency on `monica.config`_.
#}

include:
  - .running
