{% for userName, user in salt['pillar.get']('users', {}).items() %}
    {% if user.get('existence') == 'absent' %}
    delete_user_{{ userName }}:
        grafana4_user.absent:
            - userName: {{ userName }}
            - require:
                - salt: update_pillar
    {% endif %}
{% endfor %}
