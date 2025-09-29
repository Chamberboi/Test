FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 8080

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src

# copy đúng đường dẫn tới file csproj
COPY Test/Test/Test/Test/Test.csproj ./ 

RUN dotnet restore

# copy toàn bộ source code
COPY . .

# publish từ đúng folder chứa csproj
WORKDIR /src/Test/Test/Test/Test
RUN dotnet publish -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=build /app/publish .
ENTRYPOINT ["dotnet", "Test.dll"]
