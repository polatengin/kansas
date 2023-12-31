var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => "Hello World!");

app.MapPost("/api/echo", (string message) => {
  var charArray = message.ToCharArray();

  Array.Reverse(charArray);

  var reversedMessage = new string(charArray);

  var machineName = Environment.MachineName;

  return $"{machineName}::{reversedMessage}";
});

app.Run();
