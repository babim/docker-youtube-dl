#!/bin/sh

DOWNLOADPATH=${DOWNLOADPATH:-/download}
if [ ! -d "$DOWNLOADPATH" ]; then mkdir -p $DOWNLOADPATH; fi

export HTTPS_PROXY="$PROXY"
export HTTP_PROXY="$PROXY"
# set ID docker run
auid=${auid:-1000}
agid=${agid:-1000}

if id user >/dev/null 2>&1; then
        echo "user exists"
else
        echo "user does not exist"

if [[ "$auid" = "0" ]] || [[ "$aguid" == "0" ]]; then
  echo "Run in ROOT user"
else
  echo "Run in user"
  if [ ! -d "/home/user" ]; then
  addgroup -g ${agid} user && \
  adduser -D -u ${auid} -G user user && \
  chown -R $auid:$agid $DOWNLOADPATH
  fi
  su - user
fi

fi

# help
echo "use youtube-dl command"
echo "---"
youtube-dl --help

# create startup run
if [ ! -f "$DOWNLOADPATH/startup.sh" ]; then
# create
cat <<EOF>> $DOWNLOADPATH/startup.sh
#!/bin/sh
# your startup command
EOF
  chmod +x $DOWNLOADPATH/startup.sh
else
# run
  $DOWNLOADPATH/startup.sh
fi

# stop and wait command
sh
