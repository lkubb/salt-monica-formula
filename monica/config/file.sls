# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_package_install = tplroot ~ ".package.install" %}
{%- from tplroot ~ "/map.jinja" import mapdata as monica with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

Monica CRM environment files are managed:
  file.managed:
    - names:
      - {{ monica.lookup.paths.config_monica }}:
        - source: {{ files_switch(
                        ["monica.env", "monica.env.j2"],
                        config=monica,
                        lookup="monica environment file is managed",
                        indent_width=10,
                     )
                  }}
      - {{ monica.lookup.paths.config_db }}:
        - source: {{ files_switch(
                        ["db.env", "db.env.j2"],
                        config=monica,
                        lookup="db environment file is managed",
                        indent_width=10,
                     )
                  }}
    - mode: '0640'
    - user: root
    - group: {{ monica.lookup.user.name }}
    - makedirs: true
    - template: jinja
    - require:
      - user: {{ monica.lookup.user.name }}
    - watch_in:
      - Monica CRM is installed
    - context:
        monica: {{ monica | json }}
