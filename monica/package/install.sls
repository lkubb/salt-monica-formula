# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as monica with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

Monica CRM user account is present:
  user.present:
{%- for param, val in monica.lookup.user.items() %}
{%-   if val is not none and param != "groups" %}
    - {{ param }}: {{ val }}
{%-   endif %}
{%- endfor %}
    - usergroup: true
    - createhome: true
    - groups: {{ monica.lookup.user.groups | json }}
    # (on Debian 11) subuid/subgid are only added automatically for non-system users
    - system: false

Monica CRM user session is initialized at boot:
  compose.lingering_managed:
    - name: {{ monica.lookup.user.name }}
    - enable: {{ monica.install.rootless }}
    - require:
      - user: {{ monica.lookup.user.name }}

Monica CRM paths are present:
  file.directory:
    - names:
      - {{ monica.lookup.paths.base }}
    - user: {{ monica.lookup.user.name }}
    - group: {{ monica.lookup.user.name }}
    - makedirs: true
    - require:
      - user: {{ monica.lookup.user.name }}

Monica CRM compose file is managed:
  file.managed:
    - name: {{ monica.lookup.paths.compose }}
    - source: {{ files_switch(['docker-compose.yml', 'docker-compose.yml.j2'],
                              lookup='Monica CRM compose file is present'
                 )
              }}
    - mode: '0644'
    - user: root
    - group: {{ monica.lookup.rootgroup }}
    - makedirs: True
    - template: jinja
    - makedirs: true
    - context:
        monica: {{ monica | json }}

Monica CRM is installed:
  compose.installed:
    - name: {{ monica.lookup.paths.compose }}
{%- for param, val in monica.lookup.compose.items() %}
{%-   if val is not none and param != "service" %}
    - {{ param }}: {{ val }}
{%-   endif %}
{%- endfor %}
{%- for param, val in monica.lookup.compose.service.items() %}
{%-   if val is not none %}
    - {{ param }}: {{ val }}
{%-   endif %}
{%- endfor %}
    - watch:
      - file: {{ monica.lookup.paths.compose }}
{%- if monica.install.rootless %}
    - user: {{ monica.lookup.user.name }}
    - require:
      - user: {{ monica.lookup.user.name }}
{%- endif %}

{%- if monica.install.autoupdate_service is not none %}

Podman autoupdate service is managed for Monica CRM:
{%-   if monica.install.rootless %}
  compose.systemd_service_{{ "enabled" if monica.install.autoupdate_service else "disabled" }}:
    - user: {{ monica.lookup.user.name }}
{%-   else %}
  service.{{ "enabled" if monica.install.autoupdate_service else "disabled" }}:
{%-   endif %}
    - name: podman-auto-update.timer
{%- endif %}
