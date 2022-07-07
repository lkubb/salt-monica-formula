# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import mapdata as monica with context %}

include:
  - {{ sls_config_file }}

Monica CRM service is enabled:
  compose.enabled:
    - name: {{ monica.lookup.paths.compose }}
{%- for param in ["project_name", "container_prefix", "pod_prefix", "separator"] %}
{%-   if monica.lookup.compose.get(param) is not none %}
    - {{ param }}: {{ monica.lookup.compose[param] }}
{%-   endif %}
{%- endfor %}
    - require:
      - Monica CRM is installed
{%- if monica.install.rootless %}
    - user: {{ monica.lookup.user.name }}
{%- endif %}

Monica CRM service is running:
  compose.running:
    - name: {{ monica.lookup.paths.compose }}
{%- for param in ["project_name", "container_prefix", "pod_prefix", "separator"] %}
{%-   if monica.lookup.compose.get(param) is not none %}
    - {{ param }}: {{ monica.lookup.compose[param] }}
{%-   endif %}
{%- endfor %}
{%- if monica.install.rootless %}
    - user: {{ monica.lookup.user.name }}
{%- endif %}
    - watch:
      - Monica CRM is installed
