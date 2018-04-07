{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'present' and 'grafana' in user.get('entitlements') %}
    create_user_{{ userName }}:
        grafana4_user.present:
            - fullname: {{ user.get('givenName') }} {{ user.get('familyName') }}
            - password: {{ user.get('password') }}
            - name: {{ userName }}
            - email: {% set emails = user.get('emails') %}
                     {% for emailValue, email in emails.items() if email.get('primary') %}
                         {{ emailValue }}
                     {% endfor %}
        {% set groups = user.get('groups') %}
        {% for group in groups if group.split(':')[0] == 'grafana' %}
            {% set orgs = group.split(',') %}
            {% for org in orgs.items() %} 
                grafana4_org.present: 
                   - name: {{ org }}
                   - user: {{ userName }}
                   - require: 
                       - grafana4_user: create_user_{{ userName }}
            {% endfor %}
        {% endfor %}
    {% endif %}
{% endfor %}
