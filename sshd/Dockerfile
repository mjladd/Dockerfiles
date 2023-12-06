FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN mkdir /.ssh
COPY hightouch_ed25519.pub   /.ssh/authorized_keys
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#Port 22/Port 7822/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# example of how to pass environmental variables to SSHD service
# by default, SSHD scrubs ENV vars
# pushing them to /etc/profile will make them available
#ENV NOTVISIBLE "in users profile"
#RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 7822
CMD ["/usr/sbin/sshd", "-D"]