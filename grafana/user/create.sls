{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'present' %}
    create_user_{{ userName }}:
        grafana4_user.present:
            - fullname: {{ user.get('givenName') }} {{ user.get('familyName') }}
            - password: {{ user.get('password') }}
            - name: {{ userName }}
            - email: {% set emails = user.get('emails') %}
                     {% for emailValue, email in emails.items() if email.get('primary') %}
                         {{ emailValue }}
                     {% endfor %}
    {% endif %}
{% endfor %}
