#!/bin/sh -e

cd /home/etuser/et
envsubst < etmain/myconfig.cfg.template > etmain/myconfig.cfg
envsubst < legacy/omni-bot/et/user/omni-bot.cfg.template > legacy/omni-bot/et/user/omni-bot.cfg
./etlded +set g_protect 1 +set omnibot_enable 1 +set omnibot_path "./legacy/omni-bot" +exec etl_server.cfg
