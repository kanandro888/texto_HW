# Estágio de build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["Texto_HW.csproj", "./"]
RUN dotnet restore "./Texto_HW.csproj"
COPY . . 
WORKDIR "/src"
RUN dotnet build "Texto_HW.csproj" -c Release -o /app/build

# Estágio de publicação
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
COPY --from=build /app/build .
ENTRYPOINT ["dotnet", "Texto_HW.dll"]
