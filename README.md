# Aseprite :space_invader: Windows :computer: Docker :whale2: Build :gear:

Repository aims to simplify and automate building process of [Aseprite](https://github.com/aseprite/aseprite). 

Inspired by [eddex/aseprite-windows-docker-build](https://github.com/eddex/aseprite-windows-docker-build), 
but builds latest released version of Aseprite!

BTW, it is recommended to buy Aseprite, if you want support development of that neat editor: https://www.aseprite.org/


## Prerequisites

- OS: Windows 10+
- Docker Desktop
    - Use Windows containers: Right click on the tray icon -> Switch to Windows containers...
- 20GB of free disk space on system drive (You can remove containers and images then)

## Usage

1. Clone the repo: `git clone git@github.com:demkom58/docker-win-aseprite-build.git`
2. Open cloned directory: `cd docker-win-aseprite-build`
3. Build image: `docker build -t demkom58/aseprite .`
4. Create a container from the image: `docker run -d demkom58/aseprite cmd` (this prints the container id)
6. Copy binaries: `docker cp <CONTAINER_ID>:aseprite\build\bin\ .\bin\`

Now you should see a folder called `bin/` and in it the Aseprite binaries!