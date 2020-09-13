FROM i386/ubuntu:18.04

ARG ET_URL=https://www.etlegacy.com/download/platform/lnx

RUN apt-get update && apt-get install -y curl nginx gettext-base

RUN useradd -m etuser
USER etuser

# make a fake 'more'
RUN mkdir -p /home/etuser/fakebin
RUN ln -s $(which ls) /home/etuser/fakebin/more 

# install et-legacy
RUN mkdir -p /home/etuser/et
WORKDIR /home/etuser
RUN curl -Lo etlegacy.sh $ET_URL && \
	chmod +x etlegacy.sh && \
	(echo y; echo n; echo y; yes) | PATH=/home/etuser/fakebin/:$PATH \
	./etlegacy.sh --prefix=/home/etuser/et && \
	rm -f ./etlegacy.sh

# cleanup
RUN rm -rf /home/etuser/fakebin

# create nginx config
COPY files/nginx.conf /etc/nginx/nginx.conf

# append extra config line + templates
RUN echo "exec myconfig.cfg" >> /home/etuser/et/etmain/etl_server.cfg
COPY files/myconfig.cfg.template /home/etuser/et/etmain/myconfig.cfg.template
COPY files/omni-bot.cfg.template /home/etuser/et/legacy/omni-bot/et/user/omni-bot.cfg.template

# lobotomize bots
# RUN sed -i 's:^moveskill.*:moveskill=0:' /home/etuser/et/legacy/omni-bot/et/user/omni-bot.cfg 

USER root
COPY init.sh /init.sh

CMD nginx && su -c /init.sh etuser

### sudo apt-get install libglu1-mesa:i386
