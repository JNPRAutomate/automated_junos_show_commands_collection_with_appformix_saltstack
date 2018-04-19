{% set body_json = data['body']|load_json %}
{% set devicename = body_json['status']['entityId'] %}
automate_show_commands:
  local.state.apply:
    - tgt: "{{ devicename }}"
    - arg:
      - junos.collect_data_and_archive_to_git
