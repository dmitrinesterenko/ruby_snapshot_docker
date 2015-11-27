FROM ubuntu:14.04
MAINTAINER Dmitri Nesterenko <me@dmitri.co>

RUN apt-get update && apt-get -y install \
  gcc \
  make \
  vim \
  wget
WORKDIR /tmp
COPY ftp.ruby-lang.org.pem /etc/ssl/certs/ftp.ruby-lang.org.pem
# I disliked doing the --no-check-certificate option
# but after 30 minutes of poking at what could be wrong
# and installing the certificate as is outlined here
# http://unix.stackexchange.com/questions/198810/unable-to-locally-verify-the-issuers-authority
# I would still receive this error
# "Unable to locally verify the issuer's authority."
RUN wget --no-check-certificate https://ftp.ruby-lang.org/pub/ruby/snapshot.tar.gz
RUN tar xvf snapshot.tar.gz
WORKDIR /tmp/snapshot
RUN ./configure
RUN make
RUN make install
RUN rm -rf /tmp/snapshot
RUN rm -rf /tmp/snapshot.tar.gz
ENTRYPOINT ["irb"]
#ENTRYPOINT ["ruby", "-v"]
#CMD ["irb"]
