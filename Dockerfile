# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy file csproj và restore
COPY Test/Test/Test.csproj Test/Test/
RUN dotnet restore Test/Test/Test.csproj

# Copy toàn bộ source code
COPY . .

# Publish từ thư mục project
WORKDIR /src/Test/Test
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Test.dll"]
