#!/bin/sh

export HTTPS_PROXY="$PROXY"
export HTTP_PROXY="$PROXY"
# set ID docker run
auid=${auid:-1000}
agid=${agid:-1000}

if getent passwd $1 > /dev/null 2>&1; then
    echo "yes the user exists"
else
    echo "No, the user does not exist"
    
if [[ "$auid" = "0" ]] || [[ "$aguid" == "0" ]]; then
  echo "Run in ROOT user"
else
  echo "Run in user"
  if [ ! -d "/home/user" ]; then
  addgroup -g ${agid} user && \
  adduser -D -u ${auid} -G user user && \
  chown -R $auid:$agid /download
  fi
  su - user
fi

fi

# help
echo "use youtube-dl command"
echo "---"
youtube-dl --help

# create startup run
if [ ! -f "/download/startup.sh" ]; then
# create
cat <<EOF>> /download/startup.sh
#!/bin/sh
# your startup command
EOF
  chmod +x /download/startup.sh
else
# run
  /cache/startup.sh
fi

# stop and wait command
sh
