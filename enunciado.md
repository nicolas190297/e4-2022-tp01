# Ejercicios de programación en ensamblador.

Al completar este trabajo práctico habrás alcanzado los siguientes objetivos:

- Instalar Visual Studio Code
- Instalar la extensión PlatformIO
- Instalar la extensión Live Share
- Hacer fork de un repositorio en GitHub
- Configurar la extensión "GitHub" de Visual Studio Code para trabajar con una cuenta GitHub
- Clonar un repositorio remoto
- Programar un microcontrolador STM32F103C8
- Ejecutar pruebas de software en un microcontrolador STM32F103C8
- Escribir rutinas en ensamblador para un microcontrolador Cortex-M3 usando disciplina de desarrollo guiado por pruebas de software.
    - Escribir una rutina de copia de memoria
    - Escribir una rutina de copia de cadena de texto ASCIIZ
    - Escribir una rutina de conversión a mayúscula con sobreescritura de cadena de texto ASCIIZ.
    - Escribir una rutina de conversión a minúscula con sobreescritura de cadena de texto ASCIIZ.

# Instalación de Visual Studio Code y extensiones

Dirígete a [code.visualstudio.com](https://code.visualstudio.com/), haz click en el vínculo de descarga correspondiente a tu plataforma (`Download for ...`) y si la autodetección falló haz click en la flecha a la derecha de ese vínculo y selecciona el instalador correcto de la lista desplegable. Una vez descargado el instalador ejecútalo e instala Visual Studio Code.

Abre Visual Studio Code, haz click en el engranaje en el sector inferior izquierdo y selecciona "Extensions" en el menú. En "Search for Extensions..." escribe "platformio". Ubica el resultado "PlatformIO IDE". Asegúrate que aparezca en la tercera línea de texto la marca de autor verificado (un tick sobre un moño azul) al lado del nombre del autor "PlatformIO". Haz click en "install" a la derecha del nombre de autor.

En el listado de extensiones busca "Live Share". Ubica el resultado "Live Share" (cuidado, hay extensiones complementarias cuyos nombres comienzan por Live Share como "Live Share Audio" que no es necesario instalar), asegúrate que el autor verificado se Microsoft e instálalo.

# Crear un repositorio en GitHub para el práctico

Si no tienes una cuenta en GitHub, dirígete a [github.com](https://github.com/). Presiona "Sing Up" en la esquina superior derecha de la página y sigue las instrucciones para crear una nueva cuenta. Manten un respaldo seguro de tus credenciales para evitar perder acceso.

Una vez logueado en GitHub dirígete a [github.com/EivGitHub2022/e4-2022-tp01](https://github.com/EivGitHub2022/e4-2022-tp01) y haz un fork del repositorio. En Visual Studio Code, en una nueva ventana presiona la combinación `<ctrl>+<mayusc>+P` para abrir la paleta de comandos, escribe clone y selecciona `Git: Clone`. Selecciona `Clone from GitHub`, la primera vez aparecerá un mensaje diciendo que la extensión "GitHub" quiere conectarse con tu cuenta de GitHub. Presiona `Allow` y se abrirá el navegador para realizar la autorización. Una vez de vuelta a Visual Studio Code selecciona en la lista el fork de e4-2022-tp01 que debe aparecer entre tus repositorios y haz click en él. Selecciona la carpeta donde crear el repostorio (se crea como una subcarpeta con el nombre del repositorio). Luego de clonar el repositorio preguntará si quieres abrirlo. Selecciona Open en el diálogo que se abre en la zona inferior derecha.

# Compilar y cargar el código en el microcontrolador

En este paso deberás tener una placa bluepill con microcontrolador STM32F103C8 y un programador/debugger STLink-V2. Debes conectar los pines `3.3V`, `GND`, `SWDIO` y `SWCLK` del programador a los correspondientes pines en el header ubicado en el lateral opuesto al conector usb de la placa bluepill usando cables terminados en conectores header individuales hembra-hembra. Conecta el programador al puerto USB de la computadora.

Abre la paleta de comandos con `<ctrl>+<mayusc>+P`, escribe `upload` y haz click en `PlatformIO: Upload` entre los resultados (ojo, no "Remote Upload" sino "Upload"). Este comando compilará el programa, lo cargará en el microcontrolador e iniciará su ejecución. La primera vez que lo hagas puede demorar unos minutos y necesita conexión a internet pues se descargarán las herramientas y librerías necesarias. Espera hasta que se complete el proceso.

Si el resultado es `[FAILED]` y ves en la terminal el mensaje `Warn : UNEXPECTED idcode: 0x2ba01477` eso significa que el microcontrolador que intentas programar es un clon. Para poder programarlo deberás indicar a OpenOCD que espere ese código de identificación en lugar del original. Debes entonces editar platformio.ini y descomentar la definición de `upload_flags` y `debug_server` (incluye también todas las líneas subsiguientes que están indentadas dentro del comentario). En `debug_server` deberás reemplazar `c:\users\Fernando\` por la carpeta home de tu instalación de windows. Si usas Linux deberás reemplazar todos las barras invertidas `\` por slashes `/` y la tu home puede escribirse directamente como una tilde quedando `~/`. Una vez hechos estos cambios guarda platformio.ini con `<ctrl>+S` y cierra el archivo (cerrando la pestaña del mismo). Repite el comando Upload y debiera funcionar.

Si el resultado es `[SUCCESS]` significa que ha compilado y cargado el programa. El programa principal en este caso hace parpadear el LED del bluepill con una frecuencia de aproximadamente un parpadeo por segundo. Puedes verificar que así sea.

# Compilar y ejecutar conjuntos de pruebas

Para poder ejecutar los conjuntos de pruebas en el microcontrolador debes contar además con un adaptador usb-uart de lógica de 3v. Conecta el pin `GND` del adaptador a uno de los pines `GND` del bluepill y el pin RX del adaptador al pin `A9` del bluepill (que durante las pruebas será configurado como salida serial). Edita platformio.ini y escribe el nombre correcto del puerto en `test_port` en lugar de `COM9`. Guarda y cierra platformio.ini.

Con el programador y el adaptador UART conectados a la PC vamos a ejecutar el conjunto de pruebas "ejemplo". Para ello en Visual Studio Code abre la paleta de comandos (`<ctrl>+<mayusc>+P`) y escribe `io: test` y selecciona `PlatformIO: Test` en el listado.

Si todo está bien configurado, luego de algunos segundos verás los resultados de las pruebas y hacia el final habrá una línea  `...======[PASSED] Took ...`, luego una lista de conjuntos de prueba ejecutados y los resultados de cada conjunto de prueba. En nuestro caso solo hay un conjunto de pruebas, ensamblador, y solo tiene una prueba que efectivamente pasa. Si viste esto significa que todo está bien configurado.

En caso de que la terminal quede con el mensaje "If you don't see any ..." probablemente haya algún problema de configuración o conexión. Revisa que el puerto serie indicado en `test_port=...` en platformio.ini sea el correspondiente al adaptador, que la masa del adaptador esté conectada a la masa de la bluepill y su pin `RX` al pin `A9` de la bluepill. Si debiste rectificar alguna conexión prueba reseteando la bluepill con su botón reset para ver si ejecuta y transmite correctamente las pruebas.

Una vez que logras ver los resultados puedes cerrar la terminal, significa que estás listo para pasar a desarrollar el código. Veamos en primer lugar la estructura del proyecto.

# Estructura de carpetas

El proyecto contiene las carpetas include, src, lib y test. En la carpeta raíz del proyecto se encuentra el archivo de configuración `platformio.ini` donde se guarda la configuración del proyecto. Las carpetas `include` y `src` alojan los encabezados y archivos fuentes del programa principal, dentro de la carpeta `lib` se ubican en subcarpetas las librerías, en una de ellas desarrollarás las funciones del práctico. En la carpeta `test` se encuentran los archivos `unittest_transport.h` y `unittest_transport.c` que contienen código para comunicar los resutados de las pruebas y en subcarpetas de `test` se ubican los distintos conjuntos de pruebas. Por defecto las pruebas de software operan sobre las librerías en `lib` y no sobre el programa principal en `src`. Esto se debe a que cada conjunto de prueba define su propia función `main`, que entraría en conflicto con `main` del programa principal. La idea es realizar un diseño modular, ubicando los módulos dentro de subcarpetas de `lib`, y que el programa principal simplemente los configure y utilice para generar la aplicación final. Tu trabajo irá en la librería ubicada en `lib/ensamblador` y las pruebas que verifican su funcionamiento están en el conjunto de pruebas `test/ensamblador`.

La librería `ensamblador` es la librería en la que se desarrollará el código de esta práctica. Consiste en dos archivos, `ensamblador.h` y `ensamblador.s`. El archivo `.h` es un encabezado de lenguaje C que contiene los prototipos de las funciones a implementar para que estas puedan ser llamadas desde las purebas, escritas en dicho lenguaje. El archivo `.s` es un listado de ensamblador que en este momento incluye definiciones vacías (llamadas stubs) de las funciones de la librería.

# Metodología de trabajo

Esta sección te guiará en la implementación de distintas rutinas en ensamblador. Cada rutina está especificada en forma general en esta sección y para cada una hay un conjunto de pruebas que verifican el comportamiento deseado. En este momento todas menos una están comentadas y no se ejecutan. Las irás habilitando de una en una a medida que avances en el práctico hasta tener todas habilitadas y pasando lo que marca que tu práctico está completo.

Las pruebas están definidas en el archivo `test/ensamblador/test_ensamblador.c`. Cada prueba está definida en una función `static` de C (no accesible fuera del archivo) separada, y la función `main` se encarga de ejecutar las pruebas. Verás que hay varios llamados a RUN_TEST dentro de `main` que se encuentran comentados. Estos llamados son los que ejecutan cada rutina de prueba. Los nombres de las rutinas de prueba están compuestos por el nombre de la rutina en ensamblador y el enunciado del comportamiento que prueban. El cuerpo de las rutinas de prueba será un ejemplo simple de uso de la rutina bajo prueba en donde se ejercita el comportamiento buscado.

La forma de trabajo es la siguiente:

1. Habilita la siguiente prueba y asegurarte que falle (si pasa no es necesario hacer más, habilita otra). Al salir de este paso hay exactamente una prueba que falla. Si ninguna prueba falla el práctico está completo, considera la parte extra más abajo. 
2. Implementa el código estríctamente necesario para hacer que pasen *todas las pruebas*. Solo cuando todas las pruebas están pasando puedes continuar con el paso 3.
3. Haz un commit de tus cambios hasta aquí explicando el comportamiento que implementaste (el nombre de la prueba te dará una buena idea).
4. Mejora la calidad de tu código. Ahora que sabes que tu código funciona, es momento de mejorarlo. Asegúrate que siguen pasando todas las pruebas luego de cada acción. Cuando estés conforme y *todas las pruebas están pasando* continúa con el paso 5.
5. Si hiciste cambios durante el paso anterior debes hacer un nuevo commit explicando tus cambios en el mensaje. Mientras resten pruebas por habilitar, continúa en el paso 1.

## Depuración

Si sucede que el programa no funciona como esperas y no logras ver tu error, una opción es usar el depurador. El proyecto está configurado de modo que la depuración sea sobre el conjunto de pruebas `ensamblador` y no sobre el programa principal. Esta configuración es especificada por el parámetro `debug_test` en `platformio.ini`. Si deseas depurar el programa principal simplemente comenta esa línea en `platformio.ini`

# Especificación

A continuación verás la especificación en alto nivel de cada rutina en ensamblador que debes escribir. Las pruebas del conjunto ensamblador constituyen una especificación ejecutable basada en ejemplos y permiten comprobar el comportamiento en forma automática mediante su ejecución.

## Copia Memoria

Dadas dos regiones de memoria contigua, no necesariamente alineadas y de longitud bytes de extensión denominadas origen y destino. La rutina `copiaMemoria` debe copiar longitud bytes de la región origen a la región destino.

El prototipo de la rutina `copiaMemoria` es el siguiente:

```c
void copiaMemoria(const void * baseOrigen,void * baseDestino,size_t longitud);
```
donde `baseOrigen` y `baseDestino` son las direcciones iniciales de las regiones de memoria de origen y destino; y `longitud` es la extensión en bytes de cada región. Recuerda que según el estándar de llamado a procedimiento de ARM `baseOrigen` se guarda en `R0`, `baseDestino` en `R1` y `longitud` en `R2`. 


## Copia Cadena

Una cadena ASCIIZ (formato usado por la librería estándar del lenguaje C) consiste, dada su dirección de inicio (byte más bajo en memoria perteneciente a la cadena) en cero o más bytes ubicados de manera contigua a partir de la dirección de inicio con valores el rango `0x01` a `0xFF` seguidos de un byte con valor `0x00` llamado terminador nulo o caracter nulo.

Dada una cadena ASCIIZ de origen y una región de memoria de destino con longitud suficiente para acomodarla, la rutina `copiaCadena` debe copiar la cadena ASCIIZ en la región destino. No alterará los bytes de la región de destino que no fueron ocupados al copiar la cadena.

Dada una cadena ASCIIZ de origen y una región de memoria de destino con longitud $l$ que no es suficiente para acomodarla, entonces la rutina `copiaCadena` debe copiar $l-1$ caracteres en la región de destino seguidos de un terminador nulo.

El prototipo de la rutina `copiaCadena` es el siguiente
```c
void copiaCadena(const char * origen, char * baseDestino, size_t longitudDestino);
```

## Pasar a mayúscula sobreescribiendo la cadena original

Dada una cadena ASCIIZ correctamente terminada y ubicada en una región de longitud suficiente para contenerla, la rutina `mayusculaEnLugar` debe recorrer la cadena y sobreescribir los valores correspondientes a letras minúsculas en código ASCII por los valores de las correspondientes letras mayúsculas.

Dada una cadena ASCII sin el terminador nulo en una región de longitud dada, `mayusculaEnLugar` procede como en el caso anterior pero se detiene al llegar al límite de la región de memoria especificada.

El prototipo de la rutina `mayusculaEnLugar` es el siguiente
```c
void mayusculaEnLugar(char * cadena,size_t longitud);
```

## Pasar de minúscula sobreescribiendo la cadena original

Dada una cadena ASCIIZ correctamente terminada y ubicada en una región de longitud suficiente para contenerla, la rutina `minusculaEnLugar` debe recorrer la cadena y sobreescribir los valores correspondientes a letras mayúsculas en código ASCII por los valores de las correspondientes letras minúsculas.

Dada una cadena ASCII sin el terminador nulo en una región de longitud dada, `minusculaEnLugar` procede como en el caso anterior pero se detiene al llegar al límite de la región de memoria especificada.

El prototipo de la rutina `minusculaEnLugar` es el siguiente
```c
void minusculaEnLugar(char * cadena,size_t longitud);
```

## Extra

Refactorizar la rutina `copiaMemoria` para hacer un uso más eficiente del procesador.

- Copiando palabras cuando sea posible
- Copiando múltiples palabras por vez cuando sea posible

Identificar un patrón detrás de "mayusculaEnLugar" y "minusculaEnLugar" y extraerlo mediante refactorización del código (el comportamiento y la API pública permanecerá idéntica).
