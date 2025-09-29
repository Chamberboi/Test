# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish -c Release -o /app/out

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /app/out .
# Render sẽ cung cấp PORT=10000
ENV ASPNETCORE_URLS=http://+:10000
ENTRYPOINT ["dotnet", "Test.dll"]
