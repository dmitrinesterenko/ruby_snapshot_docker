FROM ubuntu:14.04
MAINTAINER Dmitri Nesterenko <me@dmitri.co>

RUN apt-get update && apt-get -y install \
  gcc \
  make \
  vim \
  wget
WORKDIR /tmp
# Install the GlobalSign Domain Validation certificate
# and use it during the download
COPY GlobalSign_Domain_Validation_CA.pem /etc/ssl/certs/GlobalSign_Domain_Validation_CA.pem
RUN wget --ca-certificate=/etc/ssl/certs/GlobalSign_Domain_Validation_CA.pem https://ftp.ruby-lang.org/pub/ruby/snapshot.tar.gz
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
