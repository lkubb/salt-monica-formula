# vim: ft=sls


{#-
    Stops the monica, db container services
    and disables them at boot time.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as monica with context %}

monica service is dead:
  compose.dead:
    - name: {{ monica.lookup.paths.compose }}
{%- for param in ["project_name", "container_prefix", "pod_prefix", "separator"] %}
{%-   if monica.lookup.compose.get(param) is not none %}
    - {{ param }}: {{ monica.lookup.compose[param] }}
{%-   endif %}
{%- endfor %}
{%- if monica.install.rootless %}
    - user: {{ monica.lookup.user.name }}
{%- endif %}

monica service is disabled:
  compose.disabled:
    - name: {{ monica.lookup.paths.compose }}
{%- for param in ["project_name", "container_prefix", "pod_prefix", "separator"] %}
{%-   if monica.lookup.compose.get(param) is not none %}
    - {{ param }}: {{ monica.lookup.compose[param] }}
{%-   endif %}
{%- endfor %}
{%- if monica.install.rootless %}
    - user: {{ monica.lookup.user.name }}
{%- endif %}
