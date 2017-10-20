# Ansible Role: WordPress

Ansible role that installs and configures WordPress.



## Installation



## Example playbook
```yaml
- hosts: all
  vars:
    wp_version: 4.0
    wp_install_dir: '/var/sites/awesome_wordpress_site'
    wp_db_name: 'database_name_here'
    wp_db_user: 'username_here'
    wp_db_password: 'password_here'
    wp_db_host: 'localhost'
  roles:
  - darthwade.wordpress
```

## Testing
```shell 
$ git clone https://github.com/darthwade/ansible-role-wordpress.git
$ cd ansible-role-wordpress
$ vagrant up
```