FROM mcr.microsoft.com/dotnet/core/sdk:7 AS build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:7
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "api.dll"]
