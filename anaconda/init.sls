{% from "anaconda/map.jinja" import anaconda with context %}

/var/anaconda-install.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 0555
    - source: {{ anaconda.source }}
    - source_hash: {{ anaconda.source_hash }}

{% for user in anaconda.users %}
/var/anaconda-install.sh -bfp /home/{{user}}/anaconda:
  cmd.run:
    - creates: /home/{{user}}/anaconda
    - user: {{user}}
    - shell: /bin/bash

yes | PATH=/home/{{user}}/anaconda/bin conda update conda:
  cmd.run:
    - user: {{user}}
    - shell: /bin/bash
{% endfor %}

