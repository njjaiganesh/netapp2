FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source

# copy csproj and restore as distinct layers
COPY *.sln .
COPY netapp2/*.csproj ./netapp2/
RUN dotnet restore

# copy everything else and build app
COPY netapp2/. ./netapp2/
WORKDIR /source/netapp2
RUN dotnet publish -c release -o /app --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "netapp2.dll"]