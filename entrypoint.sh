#!/bin/sh

DOWNLOADPATH=${DOWNLOADPATH:-/download}
if [ ! -d "$DOWNLOADPATH" ]; then mkdir -p $DOWNLOADPATH; fi

export HTTPS_PROXY="$PROXY"
export HTTP_PROXY="$PROXY"
# set ID docker run
auid=${auid:-1000}
agid=${agid:-$auid}
auser${auser:-user}

if id $auser >/dev/null 2>&1; then
        echo "user exists"
        if [[ "$auid" = "0" ]] || [[ "$aguid" == "0" ]]; then
          echo "Run in ROOT user"
        else
          echo "Run in $auser"
          # login user
          su - user
        fi
else
        echo "user does not exist"
        addgroup -g ${agid} ${auser} && \
        adduser -D -u ${auid} -G ${auser} ${auser} && \
        chown -R $auid:$agid $DOWNLOADPATH
        # fix su command user
        sed -i '$ d' /etc/passwd
        echo "$auser:x:$auid:$agid:Linux User:/home/$auser:/bin/sh" >> /etc/passwd
        # login user
        su - ${auser}
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
