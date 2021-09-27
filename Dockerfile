FROM alpine:latest
 
RUN apk add --no-cache \
 openjdk8-jre \
 mailx \
 postfix \
 unzip \
 libc6-compat \
 curl \
 tzdata \
 dateutils \
 sed

RUN mkdir /tmp/pkg \
 && cd /tmp/pkg \
 && wget https://aka.ms/downloadazcopy-v10-linux \
 && tar -xvf downloadazcopy-v10-linux \
 && cp ./azcopy_linux_amd64_*/azcopy /usr/bin/

RUN cd /tmp/pkg \
 && wget https://downloads.anaplan.com/add-ins/connect/anaplan-connect-2.1.0.zip \
 && mkdir /usr/local/anaplan-connect \
 && cd /usr/local/anaplan-connect \
 && unzip /tmp/pkg/anaplan-connect-2.0.0.zip

RUN /bin/ln -s /usr/share/zoneinfo/Asia/Singapore /etc/localtime
RUN rm -f /etc/crontabs/root && /bin/ln -s /anaplan/config/scheduled-jobs /etc/crontabs/root
RUN rm -rf /tmp/pkg

ENTRYPOINT ["/anaplan/scripts/entrypoint.sh"]

CMD ["postfix", "start-fg"]
