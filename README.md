# docker plexpass

This is a Dockerfile to set up (https://plex.tv/ "Plex Media Server") - (https://plex.tv/)

If you haven't paid for plexpass goto

For the paid for plex version goto https://github.com/timhaak/docker-plex

Build from docker file

```
git clone git@github.com:timhaak/docker-plexpass.git
cd docker-plexpass
docker build -t timhaak/plexpass .
```

You can also obtain it via:

```
docker pull timhaak/plexpass
```

---
Instructions to run:

```
docker rm -f plexpass
docker run --restart=always -d --name plexpass -h *your_host_name* -v /*your_config_location*:/config -v /*your_videos_location*:/data -p 32400:32400 timhaak/plexpass
```
or for auto detection to work add --net="host". Though be aware this more insecure and not best practice with docker images.

The only reason for doing it is to allow Avahi to work (As it uses broadcasts will not cross network boundries). If anyone knows of a better method please shout and we can get it added.

See https://docs.docker.com/articles/networking/#how-docker-networks-a-container

```
docker rm -f plexpass
docker run --restart=always -d --name plexpass --net="host" -h *your_host_name* -v /*your_config_location*:/config -v /*your_videos_location*:/data timhaak/plexpass
```

The first time it runs, it will initialize the config directory.


# Options


| Name                  |  Values              | Behaviour                                                                           |
| ---------------------:|:--------------------:| :-----------------------------------------------------------------------------------|
| SKIP_CHOWN_CONFIG     | `TRUE` or `FALSE`    | Startup will be faster and there won't be a permissions check for the configuration |
| PLEX_USERNAME         | String               | Will add this Plex Media Server to that account                                     |
| PLEX_PASSWORD         | String               | (Mandatory if username is set) The account password                                 |
| PLEX_TOKEN            | [Plex token][1]      | Plex token if you don't want to write your password                                 |
| PLEX_EXTERNALPORT     | Integer              | The port if you're not using the default one (32400), ie. when using `-p 80:34200`  |
| PLEX_DISABLE_SECURITY | `0` or `1`           | If set to 1, the remote security will be disabled                                   |
| RUN_AS_ROOT           | `TRUE` or `FALSE`    | *Dangerous* If true, will start Plex as root                                        |
| PLEX_ALLOWED_NETWORKS | Comma-separated list | List of networks to allow access to. Defaults to the docker network (public Plex)   |


To use an option, set it as a Docker environment variable :

Example:
```
docker run -e RUN_AS_ROOT=TRUE ... timhaak/plexpass
```

---

Start the docker instance again and it will stay as a daemon and listen on port 32400.

Browse to: ```http://*ipaddress*:32400/web``` to run through the setup wizard.



[1]: https://support.plex.tv/hc/en-us/articles/204059436-Finding-your-account-token-X-Plex-Token
