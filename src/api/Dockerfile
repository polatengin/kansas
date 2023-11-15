FROM mcr.microsoft.com/dotnet/sdk:8.0-bookworm-slim AS build
WORKDIR /app
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0-alpine3.18
WORKDIR /app
COPY --from=build /app/out ./
ENTRYPOINT ["dotnet", "api.dll"]

EXPOSE 5000
