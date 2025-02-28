# Usando a imagem oficial do .NET SDK como base
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80

# Usando a imagem do .NET SDK para compilar o projeto
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["texto_HW/Texto_HW.csproj", "texto_HW/"]
RUN dotnet restore "texto_HW/Texto_HW.csproj"
COPY . .
WORKDIR "/src/Texto_HW"
RUN dotnet build "Texto_HW.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Texto_HW.csproj" -c Release -o /app/publish

# Definindo a imagem final com a aplicação publicada
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Texto_HW.dll"]
