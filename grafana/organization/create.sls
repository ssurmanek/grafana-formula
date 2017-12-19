{% set bind_host = salt['pillar.get']('grafana:bind_host', '127.0.0.1') %}
{% set bind_port = salt['pillar.get']('grafana:bind_port', '3000') %}

{% for id in salt['pillar.get']('organizations', {}).items() %}
create_org_{{ id }}:
  cmd.run:
    - name: >-
        curl -XPOST --user {{ salt['pillar.get']('grafana:admin_username') }}:{{ salt['pillar.get']('grafana:admin_password') }}  -H "Content-type: application/json" -d '{ "name": "{{ id }}" }' 'http://{{ bind_host }}:{{ bind_port }}/api/orgs'
{% endfor %} 
