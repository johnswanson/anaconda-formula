/var/anaconda-install.sh:
  file.managed:
    - user: root
    - group: root
    - mode: 0555
    {% if grains['cpuarch'] == 'x86_64' %}
    - source: https://jds.objects.dreamhost.com/Anaconda-2.1.0-Linux-x86_64.sh
    - source_hash: sha512=aea987a879e43e26753136391860503e783a7ff20a0db115389774410586615371919e8a8b05c40f62e4a9258b8004cde4b65481b6b42b4ff0da877587531198
    {% elif grains['cpuarch'] == 'x86' %}
    - source: https://jds.objects.dreamhost.com/Anaconda-2.1.0-Linux-x86.sh
    - source_hash: sha512=db497942596701b660b4e2e93d87e02b8f76a3d65874f827291dc729937bc955732fc6a9556f6bf9d367244c460a37352218d4df2ede0a64cad798a49a77c656
    {% endif %}

{% for user in salt['pillar.get']('anaconda:users') %}
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

