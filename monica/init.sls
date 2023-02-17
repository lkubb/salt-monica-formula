# vim: ft=sls

{#-
    *Meta-state*.

    This installs the monica, db containers,
    manages their configuration and starts their services.
#}

include:
  - .package
  - .config
  - .service
