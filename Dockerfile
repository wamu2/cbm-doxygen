FROM alpine:3.12

LABEL maintainer="w.f.j.mueller@gsi.de" \
      description="CBM Doxygen CI/CD environment"

COPY install.sh /tmp/
RUN cd /tmp && ./install.sh

CMD sh
