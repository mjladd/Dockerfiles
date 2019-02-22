## What does the dockerfile do

This docker container builds a Centos 7 docker container for running Jenkins. 

1. There is a list of arguments that are used for both configuration and environmental variables. 
  * user
  * group
  * uid
  * gid
  * http_port
  * agent_port
  * TINI_VERSION
  * password
  * JENKINS_HOME
  * JENKINS_SLAVE_AGENT_PORT

1. RPM repositories are added for installing jenkins and docker service. 

1. RPM updates and build requirements are installed

1. tini is installed
  * tini is a tiny 'init' for use in containers
  * tini spawns a single child, reaps zombies when exiting, and performs signal forwarding


