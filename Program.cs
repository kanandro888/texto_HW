using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Criando um endpoint POST para gravar no arquivo texto_HW.txt
app.MapPost("/escrever", async (HttpContext context) =>
{
    // O caminho do arquivo onde o texto será salvo
    string filePath = Path.Combine(Directory.GetCurrentDirectory(), "texto_HW.txt");

    // Verificando se o corpo da requisição contém dados
    using (var reader = new StreamReader(context.Request.Body))
    {
        var texto = await reader.ReadToEndAsync();

        // Escrevendo no arquivo texto_HW.txt
        try
        {
            await File.WriteAllTextAsync(filePath, texto);
            return Results.Ok("Texto gravado com sucesso!");
        }
        catch (Exception ex)
        {
            return Results.BadRequest($"Erro ao gravar no arquivo: {ex.Message}");
        }
    }
});

app.Run();
