[![](https://images.microbadger.com/badges/image/babim/youtube-dl.svg)](https://microbadger.com/images/babim/youtube-dl "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/youtube-dl.svg)](https://microbadger.com/images/babim/youtube-dl "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/babim/youtube-dl:single.svg)](https://microbadger.com/images/babim/youtube-dl:single "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/babim/youtube-dl:single.svg)](https://microbadger.com/images/babim/youtube-dl:single "Get your own version badge on microbadger.com")

thanks wernight

What is YouTube-DL?
==================

[youtube-dl](https://github.com/rg3/youtube-dl) is a command-line program to download videos from YouTube.com and other video sites.

# Usage
```
docker run -it --name youtube-dl -v /download:/download babim/acdcli
```
If not have uid and gid option. Default run in uid 1000 add uid and gid option
or set 0 to run with root
```
-e auid="0" -e agid="0"
```
I you want use https proxy
```
-e PROXY=https://test.lan:8443
```
If want mount
`--privileged`

volume -v
```
DOWNLOADPATH default: /download
```
