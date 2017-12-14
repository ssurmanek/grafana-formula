{% for id, user in salt['pillar.get']('users', {}).items() %}
create_user_{{ id }}:
  cmd.run:
    - name: >-
        curl -XPOST -H 'Authorization: Basic YWRtaW46YWRtaW4='  -H "Content-type: application/json" -d '{ "name": "site.get('name')", "email": "site.get('email')", "login": "{{ id }}", "password":"site.get('password')" }' 'http://172.17.1.64:3000/api/admin/users'
{% endfor %}      
