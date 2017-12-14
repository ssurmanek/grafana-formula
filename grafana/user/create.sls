# curl -XPOST -H 'Authorization: Basic YWRtaW46YWRtaW4=' -H "Content-type: application/json" -d '{
#   "name":"User",
#   "email":"user@graf.com",
#   "login":"user",
#   "password":"userpassword"
# }' 'http://172.17.1.64:3000/api/admin/users'

create_new_user:
  cmd.run:
    - name: >-
        curl -XPOST -H 'Authorization: Basic YWRtaW46YWRtaW4='  -H "Content-type: application/json" -d '{ "name": "saltUser", "email": "user@salt.com", "login": "salt", "password":"userpassword" }' 'http://172.17.1.64:3000/api/admin/users'
        
