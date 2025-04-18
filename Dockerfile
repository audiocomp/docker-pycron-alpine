FROM python:3.13-alpine
LABEL maintainer="Steve Brown https://github.com/audiocomp"

# Update base image and install dependencies
RUN apk update && apk upgrade --no-cache -v && apk add --no-cache -v gcc libc-dev make git libcap ca-certificates busybox-openrc logrotate openssl rsyslog wget

# Update PIP and install required packages
COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip && pip install --no-cache-dir -r /tmp/requirements.txt

# Add Volumes
VOLUME /work
VOLUME /share

# Create Directories & add code
WORKDIR /app
RUN mkdir -p /app /var/spool/rsyslog /etc/cron.d
COPY VERSION VERSION
COPY app/ .
COPY system/rsyslog.conf /etc/rsyslog.conf
RUN chmod +x /app/start.sh
RUN chmod +x /app/run.py
RUN python setup.py bdist_wheel && pip install dist/*.whl && rm -rf build dist *egg.info

# Run PyCron
WORKDIR /work
CMD ["/app/start.sh"]
