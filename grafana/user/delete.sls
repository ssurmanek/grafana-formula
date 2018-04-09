{% for userName, user in salt['pillar.get']('users_relative', {}).items() %}
    {% if user.get('existence') == 'absent' and 'grafana-minion' in user.get('entitlements') %}
    delete_user_{{ userName }}:
        grafana4_user.absent:
            - name: {{ userName }}
    {% endif %}
{% endfor %}
