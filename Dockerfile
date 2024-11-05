#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER root
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

RUN chmod -R 755 /app

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["HelloWorldAPI/HelloWorldAPI.csproj", "HelloWorldAPI/"]
RUN dotnet restore "HelloWorldAPI/HelloWorldAPI.csproj"
COPY . .
WORKDIR "/src/HelloWorldAPI"
RUN dotnet build "HelloWorldAPI.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "HelloWorldAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

RUN mkdir -p /app/certificates
COPY certificates/aspnetapp.pfx /app/certificates
RUN ls

ENTRYPOINT ["dotnet", "HelloWorldAPI.dll"]