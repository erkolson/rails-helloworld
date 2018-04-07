FROM ubuntu:16.04

COPY install-init-rails.sh /
RUN /install-init-rails.sh

WORKDIR /helloworld

ENTRYPOINT ["bin/rails"]
CMD ["s", "-b", "0.0.0.0", "-p", "80"]
