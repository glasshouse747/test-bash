- name: Install MySQL Server
  ansible.builtin.dnf:
    name: mysql-sever
    state: latest

- name:
  ansible.systemd_service:
    name: mysqld
    state: latest
    enabled: yes

- name: Setup MySQL Root Password
  ansible.builtin.shell: mysql_secure_installation --set-root-pass RoboShop@1
