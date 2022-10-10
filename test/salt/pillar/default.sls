# -*- coding: utf-8 -*-
# vim: ft=yaml
---
monica:
  lookup:
    master: template-master
    # Just for testing purposes
    winner: lookup
    added_in_lookup: lookup_value
    compose:
      create_pod: null
      pod_args: null
      project_name: monica
      remove_orphans: true
      build: false
      build_args: null
      pull: false
      service:
        container_prefix: null
        ephemeral: true
        pod_prefix: null
        restart_policy: on-failure
        restart_sec: 2
        separator: null
        stop_timeout: null
    paths:
      base: /opt/containers/monica
      compose: docker-compose.yml
      config_monica: monica.env
      config_db: db.env
      data: data
      db: db
    user:
      groups: []
      home: null
      name: monica
      shell: /usr/sbin/nologin
      uid: null
      gid: null
    containers:
      db:
        image: docker.io/library/mysql:5.7
      monica:
        image: docker.io/library/monica:apache
  install:
    rootless: true
    remove_all_data_for_sure: false
  config:
    allow_statistics_through_public_api_access: false
    app:
      debug: false
      disable_signup: true
      email_new_users_notification: null
      env: production
      force_url: false
      key: null
      signup_double_optin: false
      trusted_cloudflare: false
      trusted_proxies: []
      url: http://localhost
    aws:
      bucket: null
      key: null
      region: us-east-1
      secret: null
      server: null
    cache_driver: database
    check_version: true
    dav_enabled: true
    db:
      connection: mysql
      database: monica
      host: db
      password: null
      port: 3306
      prefix: ''
      test:
        database: monica_test
        host: 127.0.0.1
        password: secret
        username: homestead
      unix_socket: null
      use_utf8mb4: true
      username: monica
    default_filesystem: public
    default_max_storage_size: 512
    default_max_upload_size: 10240
    enable_geolocation: false
    enable_weather: false
    hash:
      length: 18
      salt: null
    location_iq_api_key: null
    log_channel: daily
    mail:
      encryption: null
      from_address: null
      from_name: Monica instance
      host: mailtrap.io
      mailer: smtp
      password: null
      port: 2525
      username: null
    mfa_enabled: true
    passport_password_grant:
      client_id: null
      client_secret: null
    policy_compliant: true
    queue_connection: sync
    rate_limit:
      per_minute_api: 60
      per_minute_oauth: 5
    redis_host: null
    s3_path_style: null
    sentry:
      laravel_dsn: null
      support: false
    session:
      driver: file
      lifetime: 120
    weatherapi_key: null
  host_port: 3014

  tofs:
    # The files_switch key serves as a selector for alternative
    # directories under the formula files directory. See TOFS pattern
    # doc for more info.
    # Note: Any value not evaluated by `config.get` will be used literally.
    # This can be used to set custom paths, as many levels deep as required.
    files_switch:
      - any/path/can/be/used/here
      - id
      - roles
      - osfinger
      - os
      - os_family
    # All aspects of path/file resolution are customisable using the options below.
    # This is unnecessary in most cases; there are sensible defaults.
    # Default path: salt://< path_prefix >/< dirs.files >/< dirs.default >
    #         I.e.: salt://monica/files/default
    # path_prefix: template_alt
    # dirs:
    #   files: files_alt
    #   default: default_alt
    # The entries under `source_files` are prepended to the default source files
    # given for the state
    # source_files:
    #   monica-config-file-file-managed:
    #     - 'example_alt.tmpl'
    #     - 'example_alt.tmpl.jinja'

    # For testing purposes
    source_files:
      Monica CRM environment file is managed:
      - monica.env.j2

  # Just for testing purposes
  winner: pillar
  added_in_pillar: pillar_value
