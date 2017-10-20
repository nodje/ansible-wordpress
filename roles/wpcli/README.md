# Install Wordpress cli

installs wb cli by downloading it from 
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
or runs `wp cli update` if the command already exists
 
## search-replace
cf. https://developer.wordpress.org/cli/commands/search-replace/

`sudo -uwww-data wp search-replace <old> <new> --dry-run`