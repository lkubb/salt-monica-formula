# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as monica with context %}

include:
  - {{ sls_service_clean }}

# This does not lead to the containers/services being rebuilt
# and thus differs from the usual behavior
Monica CRM environment files are absent:
  file.absent:
    - names:
      - {{ monica.lookup.paths.config_monica }}
      - {{ monica.lookup.paths.config_db }}
    - require:
      - sls: {{ sls_service_clean }}
