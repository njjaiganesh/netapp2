FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

COPY *.sln .
COPY netapp2/*.csproj ./netapp2/
RUN dotnet restore

COPY netapp2/. ./netapp2/
WORKDIR /source/netapp2
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT [dotnet, netapp2.dll]
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

COPY *.sln .
COPY netapp2/*.csproj ./netapp2/
RUN dotnet restore

COPY netapp2/. ./netapp2/
WORKDIR /source/netapp2
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "netapp2.dll"]
