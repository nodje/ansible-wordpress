[![Build Status](https://travis-ci.org/nodje/ansible-wordpress.svg?branch=master)](https://travis-ci.org/nodje/ansible-wordpress)

NB: The address IP must be used in domain-host and domain and project-name must be set to hostname shortname 

@TODO:
- change wordpress git ssh key generation in favor of forward-agent
- test option needed
    - deactivate full system upgrade
    - deactivate git nightly backup

- change the way certbot is installed: use squeeze backport
- add to vhost config:
```aidl
            location ~ ^/wp-admin {
                    allow 85.234.144.9;
                    allow 114.242.13.180;
                    allow 176.188.98.203;
                    allow 81.57.82.186;
                    deny all;
            }
```
