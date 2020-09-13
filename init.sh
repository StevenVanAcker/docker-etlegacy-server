#!/bin/sh -e

cd /home/etuser/et
# process config files
envsubst < etmain/myconfig.cfg.template > etmain/myconfig.cfg
envsubst < legacy/omni-bot/et/user/omni-bot.cfg.template > legacy/omni-bot/et/user/omni-bot.cfg

# link to maps
if [ -d /maps ];
then
	for i in /maps/*;
	do
		n=$(basename $i)
		target=/home/etuser/et/etmain/$n
		if [ ! -e $target ]; then 
			echo "Creating link to map file $i from $target";
			ln -s $i $target; 
		fi
	done
fi

# start server
./etlded +set g_protect 1 +set omnibot_enable 1 +set omnibot_path "./legacy/omni-bot" +exec etl_server.cfg
