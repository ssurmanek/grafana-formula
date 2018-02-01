{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'absent' %}
    delete_user_{{ userName }}:
        grafana4_user.absent:
            - name: {{ userName }}
    {% endif %}
{% endfor %}
