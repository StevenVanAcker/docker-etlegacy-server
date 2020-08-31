FROM i386/ubuntu:18.04

ARG ET_URL=https://www.etlegacy.com/download/platform/lnx

RUN apt-get update && apt-get install -y curl

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

# append extra config line
RUN echo "exec myconfig.cfg" >> /home/etuser/et/etmain/etl_server.cfg


### - name: append loading extra config
###   lineinfile: dest=/opt/et/etmain/etl_server.cfg line="exec myconfig.cfg"
### 
### - name: copy config template
###   copy: src=myconfig.cfg.j2 dest=/opt/et/etmain/myconfig.cfg.j2
### 
### - name: copy start script
###   copy: src=start_et.sh dest=/home/{{ansible_user}}/start_et.sh mode=0755
### 
### - name: copy readme
###   copy: src=et.README.maps dest=/home/{{ansible_user}}/et.README.maps
### 
### - name: create config file
###   template: src=et.yaml.j2 dest=/home/{{ansible_user}}/et.yaml owner={{ansible_user}}
### 
### - name: create symlink to maps folder
###   file: src=/opt/et/legacy/ dest=/home/{{ansible_user}}/et.maps state=link
### 
### - name: set moveskill to 0 for omnibots
###   lineinfile: dest=/opt/et/legacy/omni-bot/et/user/omni-bot.cfg regexp='^moveskill                      =' line='moveskill                      = 0'
### 
### - name: allow apache to read pk3 files
###   copy: src=000-default.conf dest=/etc/apache2/sites-available/000-default.conf
###   register: apachepk3
### 
### - name: restart apache if needed
###   service: name=apache2 state=restarted
###   when: apachepk3.changed
### 
### - name: change /opt/et ownership
###   file: path=/opt/et owner={{ansible_user}} state=directory recurse=true
#https://www.etlegacy.com/download/file/84 








### For clients:
### sudo apt-get install libglu1-mesa:i386

