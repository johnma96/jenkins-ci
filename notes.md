# ngrok

Es una herramienta que crea túneles seguros desde internet hacia una aplicación o servicio que se ejecuta localmente en tu máquina, exponiéndolo al mundo exterior sin necesidad de configurar firewalls o routers, ideal para pruebas, demos y desarrollo, funcionando como un proxy inverso que proporciona una URL pública temporal (o fija con planes de pago) para acceder a tu servidor local, asegurando el tráfico con SSL/TLS y permitiendo inspección

## Curso: Se usa para exponer el puerto 8080 de jenkins, permitiendo acceder a jenkins desde internet

# webhook 

Un webhook es una notificación automática y en tiempo real que una aplicación envía a otra cuando ocurre un evento específico, funcionando como una "API inversa" al enviar datos sin que sean solicitados, a través de una solicitud HTTP POST a una URL predefinida para ejecutar flujos de trabajo o sincronizar información. Se activan por eventos (como un pago, nuevo usuario, o cambio de estado) y son cruciales para automatizar tareas entre sistemas, ahorrando recursos y mejorando la agilidad.  
¿Cómo funciona?
    - Configuración: Una aplicación (el "receptor") se configura para esperar una notificación en una URL específica (el "endpoint del webhook").
    - Evento: Ocurre algo en la aplicación original (el "emisor"), como un nuevo pedido en una tienda online.
    - Disparo: El emisor envía automáticamente una petición HTTP (generalmente POST) a esa URL con los datos del evento en formato JSON.
    - Reacción: El receptor procesa la información y ejecuta acciones programadas, como actualizar el stock o enviar un email de confirmación.
Diferencia clave con las APIs tradicionales
    - APIs (Tradicional): El cliente pregunta constantemente a la API si hay nuevos datos ("¿Ya está listo?").
    - Webhooks: La API notifica al cliente en cuanto los datos están listos ("¡Aquí tienes los datos!"), sin necesidad de consultar continuamente.

## Curso: Se usa para gestionar el ciclo CI/CD, permitiendo que jenkins se active cuando se sube un nuevo commit a github