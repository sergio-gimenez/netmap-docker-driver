FROM sergiogimenez/netmap-docker:latest

RUN apt-get install python3
RUN mkdir -p /run/docker/plugins /usr/src/app \
	&& chown -R root:root /run/docker/plugins /usr/src/app
USER root
ENV HOME=/usr/src/app
WORKDIR /usr/src/app	

COPY --chown=root:root requirements.txt .
RUN pip3 install --user --no-cache-dir -r requirements.txt

COPY --chown=root:root . .

CMD [ "./run.py" ]
