# curl -XPOST -H 'Authorization: Basic YWRtaW46YWRtaW4=' -H "Content-type: application/json" -d '{
#   "name":"User",
#   "email":"user@graf.com",
#   "login":"user",
#   "password":"userpassword"
# }' 'http://172.17.1.64:3000/api/admin/users'

{% for id, name, email, password in salt['pillar.get']('grafana:users', {}).items() %}
create_user_{{ id }}:
  cmd.run:
    - name: >-
        curl -XPOST -H 'Authorization: Basic YWRtaW46YWRtaW4='  -H "Content-type: application/json" -d '{ "name": "{{ name }}", "email": "{{ email }}", "login": "{{ id }}", "password":"{{ password }}" }' 'http://172.17.1.64:3000/api/admin/users'
{% endfor %}      
