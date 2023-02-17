# vim: ft=sls

{#-
    Removes the configuration of the monica, db containers
    and has a dependency on `monica.service.clean`_.

    This does not lead to the containers/services being rebuilt
    and thus differs from the usual behavior.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_service_clean = tplroot ~ ".service.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as monica with context %}

include:
  - {{ sls_service_clean }}

Monica CRM environment files are absent:
  file.absent:
    - names:
      - {{ monica.lookup.paths.config_monica }}
      - {{ monica.lookup.paths.config_db }}
      - {{ monica.lookup.paths.base | path_join(".saltcache.yml") }}
    - require:
      - sls: {{ sls_service_clean }}
