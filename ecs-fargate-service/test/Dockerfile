FROM alpine:latest

# Install python3 and dependencies
RUN apk --no-cache add python3 py3-pip
RUN python3 --version || exit 1

WORKDIR /app
ADD ./run.sh /app/run.sh

CMD ["/bin/sh", "/app/run.sh"]
