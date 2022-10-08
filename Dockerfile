# escape=`

FROM abrarov/msvc-2019

COPY build.bat C:\

USER ContainerAdministrator
RUN setx /M PATH "%PATH%;C:/"

USER ContainerUser
RUN C:\build.bat
