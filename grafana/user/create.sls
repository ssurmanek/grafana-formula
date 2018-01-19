{% for userName, user in salt['pillar.get']('users', {}).items() %}
    {% if user.get('existence') == 'present' %}
    create_user_{{ userName }}:
        grafana4_user.present:
            - fullname: {{ user.get('familyName') }} {{ user.get('givenName') }}
            - password: {{ user.get('password') }}
            - name: {{ userName }}
            {% set emails = user.get('emails') %}
            {% for emailValue, email in emails.items() %}
                {% if email.get('primary') == 'true'
            - email: "{{ emailValue }}"
                {% endif %}
            {% endfor %}
    {% endif %}
{% endfor %}
