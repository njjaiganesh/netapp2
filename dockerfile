from mcr.microsoft.com/dotnet/core/aspnet:3.0 AS build
# WORKDIR /source

# # copy csproj and restore as distinct layers
# COPY *.sln .
# COPY netapp2/*.csproj ./netapp2/
# RUN dotnet restore

# # copy everything else and build app
# COPY netapp2/. ./netapp2/
# WORKDIR /source/netapp2
# RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /tmp
COPY /tmp ./
ENTRYPOINT ["dotnet", "netapp2.dll"]