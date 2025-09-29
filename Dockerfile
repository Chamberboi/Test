# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# Copy file csproj và restore
COPY Test/Test/Test/Test/Test.csproj ./ 
RUN dotnet restore Test.csproj

# Copy toàn bộ source code
COPY . .

# Chuyển vào thư mục chứa project
WORKDIR /src/Test/Test
RUN dotnet publish -c Release -o /app/publish

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Test.dll"]
