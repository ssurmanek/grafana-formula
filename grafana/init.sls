grafana_repos_key:
  cmd.run:
    - name: curl https://packagecloud.io/gpg.key | sudo apt-key add -

grafana_repo:
  file.managed:
    - name: /etc/apt/sources.list.d/grafana.list
    - require:
      - cmd: grafana_repos_key
- contents: deb https://packagecloud.io/grafana/stable/debian/ jessie main

grafana_soft:
  pkg.installed:
    - name: grafana
    - require:
      - file: grafana_repo
  service.running:
    - name: grafana-server
    - enable: True
    - require:
      - pkg: grafana
