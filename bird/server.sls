{% from "bird/map.jinja" import server with context %}

{%- if 'bird' in pillar and 'server' in pillar['bird'] %}

{%- if server.get('network', {}).get('engine', 'baremetal') == 'baremetal' %}

bird_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

bird_config:
  file.managed:
  - name: {{ server.config }}
  - source: salt://bird/files/bird.conf
  - template: jinja
  - check_cmd: sh -xc 'if test -S /run/bird/bird.ctl; then birdc configure check \"$1\"; else echo "No socket, skipping check."; fi' x
  - require:
    - pkg: bird_packages

bird_service:
  service.running:
  - name: {{ server.service }}
  - enable: true
  - reload: true
  - watch:
    - file: bird_config

{%- elif server.network.engine == 'calico' %}

bird_mesh_template:
  file.managed:
  - name: /srv/calico/bird.cfg.mesh.template
  - source: salt://bird/files/calico/bird.cfg.mesh.template
  - template: jinja
  - makedirs: true

bird_no_mesh_template:
  file.managed:
  - name: /srv/calico/bird.cfg.no-mesh.template
  - source: salt://bird/files/calico/bird.cfg.no-mesh.template
  - template: jinja
  - makedirs: true

custom_filters:
  file.managed:
  - name: /srv/calico/custom_filters.cfg
  - source: salt://bird/files/calico/custom_filters.cfg
  - template: jinja
  - makedirs: true

{%- endif %}

{%- endif %}
