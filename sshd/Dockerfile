FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server supervisor

# setup sshd and copy required files
RUN mkdir /var/run/sshd
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
COPY hightouch_ed25519.pub   /root/.ssh/authorized_keys
COPY hightouch_ed25519.pub   /root/.ssh/hightouch_ed25519.pub
COPY hightouch_ed25519   /root/.ssh/hightouch_ed25519
COPY hightouch_known_hosts  /root/.ssh/known_hosts
RUN chmod 600 /root/.ssh/authorized_keys
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN sed -i 's/#Port 22/Port 7822/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# example of how to pass environmental variables to SSHD service
# by default, SSHD scrubs ENV vars
# pushing them to /etc/profile will make them available
#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

# setup supervisord
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]
CMD ["/usr/bin/supervisord"]
