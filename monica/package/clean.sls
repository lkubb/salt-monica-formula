# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as monica with context %}

include:
  - {{ sls_config_clean }}

{%- if monica.install.autoupdate_service %}

Podman autoupdate service is disabled for Monica CRM:
{%-   if monica.install.rootless %}
  compose.systemd_service_disabled:
    - user: {{ monica.lookup.user.name }}
{%-   else %}
  service.disabled:
{%-   endif %}
    - name: podman-auto-update.timer
{%- endif %}

Monica CRM is absent:
  compose.removed:
    - name: {{ monica.lookup.paths.compose }}
    - volumes: {{ monica.install.remove_all_data_for_sure }}
{%- for param in ["project_name", "container_prefix", "pod_prefix", "separator"] %}
{%-   if monica.lookup.compose.get(param) is not none %}
    - {{ param }}: {{ monica.lookup.compose[param] }}
{%-   endif %}
{%- endfor %}
{%- if monica.install.rootless %}
    - user: {{ monica.lookup.user.name }}
{%- endif %}
    - require:
      - sls: {{ sls_config_clean }}

Monica CRM compose file is absent:
  file.absent:
    - name: {{ monica.lookup.paths.compose }}
    - require:
      - Monica CRM is absent

Monica CRM user session is not initialized at boot:
  compose.lingering_managed:
    - name: {{ monica.lookup.user.name }}
    - enable: false
    - onlyif:
      - fun: user.info
        name: {{ monica.lookup.user.name }}

Monica CRM user account is absent:
  user.absent:
    - name: {{ monica.lookup.user.name }}
    - purge: {{ monica.install.remove_all_data_for_sure }}
    - require:
      - Monica CRM is absent
    - retry:
        attempts: 5
        interval: 2

{%- if monica.install.remove_all_data_for_sure %}

Monica CRM paths are absent:
  file.absent:
    - names:
      - {{ monica.lookup.paths.base }}
    - require:
      - Monica CRM is absent
{%- endif %}
