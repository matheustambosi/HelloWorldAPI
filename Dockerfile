# Use the ASP.NET runtime as the base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER app
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

# Use the SDK image to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /src

# Copy the project file and restore dependencies
COPY ["HelloWorldAPI/HelloWorldAPI.csproj", "HelloWorldAPI/"]
RUN dotnet restore "HelloWorldAPI/HelloWorldAPI.csproj"

# Copy the entire project source code
COPY . .

# Set the working directory to the project directory and build the application
WORKDIR "/src/HelloWorldAPI"
RUN dotnet build "HelloWorldAPI.csproj" -c $BUILD_CONFIGURATION -o /app/build

# Publish the application to the /app/publish directory
FROM build AS publish
RUN dotnet publish "HelloWorldAPI.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Create the final image from the published output
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "HelloWorldAPI.dll"]