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

Pasos:
0. Configuramos un server de jenkins en un servidor local usando docker
1. Creamos una tarea o job que se ejecuta manualmente, y verificamos que hiciera el clone del repo remoto y además un clean install de maven apuntando al archivo pom.xml
2. Se expuso el server de jenkins usando ngrok a internet
3. Se configuro el webhook en github para que jenkins se active cuando se sube un nuevo commit a github
4. Ahora se crea un job que se ejecuta automaticamente cuando se sube un nuevo commit a github. A diferencia del primer job, aquí seleccionamos github como el repositorio remoto y además seleccionamos la rama origin/feature** para que se active cuando se sube un nuevo commit a github
5. Seleccionamos el trigger tipo github hook trigger
6. Luego en Build steps seleccionamos Invoke top-level Maven targets y agregamos clean install

Ahora vamos a configurar un webhook en github para que jenkins se active cuando se sube un nuevo commit a github
1. Vamos a la configuración del repositorio en github y seleccionamos webhooks
2. Hacemos clic en Add webhook
3. En Payload URL ponemos la URL de ngrok + /github-webhook
4. En Content type seleccionamos application/json
5. En Which events would you like to trigger this webhook? seleccionamos Just the push event
6. Hacemos clic en Add webhook

Una vez que tenemos el webhook configurado, hemos probrado 2 automatizaciones:
1. Un job que se ejecuta manualmente y que realiza un clean install de maven apuntando al archivo pom.xml
2. Un job que ejecutamos manualmente y se encarga de hacer el merge en un pull request de github

Probadas esas 2 configuraciones, ahora vamos a integrar jenkins con slack para que nos notifique cuando se ejecuta un job.
1. Login en slack
2. Crear un canal en slack llamado jenkins
3. Instalar el plugin de slack en jenkins que se llama jenkins-ci (Aquí puede que el contenedor caiga por lo que lo volvermos a levantar con docker start jenkins-ci)
4. Hacer la conexión entre jenkins y slack usando el token de slack y pasándolo en la configuración del plugin de slack en jenkins: Sección System Configuration -> Slack
5. 