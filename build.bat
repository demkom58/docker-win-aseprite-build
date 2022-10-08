cd C:\

echo "Downloading jq utility"
powershell -command "wget -UseBasicParsing -OutFile jq.exe https://github.com/stedolan/jq/releases/download/jq-1.6/jq-win64.exe"

mkdir deps
cd deps
mkdir skia
cd skia

for /f %%i in ('curl https://api.github.com/repos/aseprite/skia/releases/latest -s ^| jq .tag_name -r') do set LATEST_SKIA=%%i
echo "(1/3) Downloading Skia binaries of version %LATEST_SKIA%"

powershell -command "wget -UseBasicParsing -OutFile skia.zip https://github.com/aseprite/skia/releases/download/%LATEST_SKIA%/Skia-Windows-Release-x64.zip"
powershell -command "Expand-Archive -Path .\skia.zip -DestinationPath ."

echo "Switching to VS dev cmd"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\Tools\VsDevCmd.bat" -arch=x64




echo "(2/3) Building ninja"
cd C:\
git clone https://github.com/ninja-build/ninja.git
cd .\ninja\
git fetch --tags

for /f %%i in ('curl https://api.github.com/repos/ninja-build/ninja/releases/latest -s ^| jq .tag_name -r') do set LATEST_NINJA=%%i
git checkout %LATEST_NINJA%
echo "Building ninja version %LATEST_NINJA%"

mkdir build-cmake
cd build-cmake
cmake ..
cmake --build .




echo "(3/3) Building aseprite"
cd C:\
git clone --recursive https://github.com/aseprite/aseprite.git
cd aseprite
git fetch --tags
git pull

for /f %%i in ('curl https://api.github.com/repos/aseprite/aseprite/releases/latest -s ^| jq .tag_name -r') do set LATEST_ASEPRITE=%%i
git checkout %LATEST_ASEPRITE%
echo "Building aseprite version %LATEST_ASEPRITE%"

git submodule update --init --recursive
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLAF_BACKEND=skia -DSKIA_DIR=C:\deps\skia -DSKIA_LIBRARY_DIR=C:\deps\skia\out\Release-x64 -DSKIA_LIBRARY=C:\deps\skia\out\Release-x64\skia.lib -G Ninja ..
ninja aseprite