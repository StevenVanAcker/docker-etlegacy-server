#!/bin/bash
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# geenrate config
jinja2 /opt/et/etmain/myconfig.cfg.j2 $DIR/et.yaml > /opt/et/etmain/myconfig.cfg

# start ET
cd /opt/et
./etlded +set g_protect 1 +set omnibot_enable 1 +set omnibot_path "./legacy/omni-bot" +exec etl_server.cfg
