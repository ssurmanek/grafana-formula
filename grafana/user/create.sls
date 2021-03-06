{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'present' and 'grafana-minion' in user.get('entitlements') %}
        create_user_{{ userName }}:
            grafana4_user.present:
                - fullname: {{ user.get('givenName') }} {{ user.get('familyName') }}
                - password: {{ user.get('password') }}
                - name: {{ userName }}
        {% set emails = user.get('emails') %}
            {% for emailValue, email in emails.items() if email.get('primary') %}
                - email: {{ emailValue }}
            {% endfor %}
        {% if 'groups' in user %} 
            {% set groups = user.get('groups') %}
            {% for group in groups if group.split(':')[0] == 'grafana-minion' %}
                {% set orgs = group.split(':')[1].split(',') %}
                {% for org in orgs %}
        assign_{{ userName }}_to_{{ org }}:
            grafana4_org.present: 
                - name: {{ org }}
                - user: {{ userName }}
                - require:
                    - grafana4_user: create_user_{{ userName }}
                {% endfor %}
            {% endfor %}
        {% endif %}
    {% endif %}
{% endfor %}
