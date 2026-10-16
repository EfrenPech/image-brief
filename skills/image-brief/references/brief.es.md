# El método en español

Referencia para leer, no para el agente. El contrato que ejecuta el agente está en `SKILL.md` (en inglés).

Fuente: https://youtu.be/FX8c_ytLuIQ y https://blog.beailabs.com/p/crear-imagenes-chatgpt

## Por qué las imágenes salen genéricas

Tres causas, y las tres se arreglan con decisiones tomadas **antes** de generar:

1. **No especificas.** Un encargo como "hazme un cartel para una verbena" deja todo abierto: tipografía, colores, ornamentos, composición. El modelo resuelve por su cuenta y cae en el promedio reconocible — farolillos, banderines, gente bailando.
2. **"Hazlo bonito" no es una instrucción.** "Bonito", "profesional" y "original" expresan intención pero no dirección visual. Hay que nombrar: un estilo con nombre, una tipografía, una paleta.
3. **No le dices qué no quieres por su nombre.** Sin la línea `Evita`, el modelo conserva sus adornos de siempre: trazos de pincel, letra cursiva, filetes horizontales, rayos radiales.

## El prompt de 7 líneas

Las siete líneas ordenan el encargo. También puedes escribirlo como párrafo; lo que importa es que las decisiones se entiendan.

```
Formato: [proporción y orientación]
Qué es: [tipo de imagen y uso]
Tema: [contenido, escena o composición principal]
Estilo: [diseño, movimiento artístico o técnica]
Texto exacto: "[texto 1]", "[texto 2]" y ningún otro texto
Tipografía y paleta: [tipo de letra y colores]
Evita: [elementos concretos que no quieres]
```

| Línea | Qué decide | Ejemplo |
| --- | --- | --- |
| Formato | orientación y proporción | Vertical 4:5 |
| Qué es | uso de la imagen | cartel para una exposición |
| Tema | información y composición | fecha, lugar y un único elemento central |
| Estilo | dirección visual | constructivismo |
| Texto exacto | todo lo que debe leerse | título, fecha y lugar entre comillas |
| Tipografía y paleta | letras y colores | sans recta; rojo, negro y crema |
| Evita | exclusiones específicas | brochazos, eslóganes, adornos alrededor del título |

El formato se decide antes de generar: una imagen vertical y una horizontal necesitan composiciones distintas. La proporción no sustituye comprobar el archivo final.

## El truco para la línea `Evita`

Antes de escribir una lista larga de prohibiciones, identifica qué te molesta. Pregúntale al modelo:

```
¿Cómo describirías el tipo de letra y los elementos decorativos
que aparecen alrededor del texto?
```

La respuesta es vocabulario — "filetes horizontales finos", "pequeños rayos o líneas radiales", "cápsulas redondeadas" — y eso se convierte directamente en tu línea `Evita`.

Una revisión concreta se evalúa mejor que cinco cambios a la vez.

## El estilo son tres capas

`Estilo` admite tres decisiones que se combinan: **diseño y maquetación** (Swiss, Art Deco, constructivismo), **ilustración o movimiento artístico** (pixel art, cubismo, surrealismo) y **técnica o acabado** (serigrafía, risografía, cianotipia). Catálogo completo en `styles.md`.

Para iterar dentro del mismo chat:

```
Genera el cartel con estilo X. Mantén las especificaciones,
el texto exacto y la línea Evita.
```

Si el chat acumula versiones con elementos que ya no quieres, abre uno nuevo y pega el encargo completo.

## Imágenes de producto

Foto de referencia + las mismas 7 líneas. Lo que cambia el tipo de imagen es `Qué es`: promocional, vista explosionada, infografía, blueprint, knolling, cutaway, rayos X, isométrico, packaging. Ver `product-images.md`.

Para cualquier imagen derivada de una foto, `Evita` suma: fondos oscuros, degradados, círculos de detalle, anotaciones, iconos, eslóganes, piezas inventadas y cambios en la forma, el color o el logotipo.

## Qué revisar antes de publicar

- **Texto:** tildes, fechas, nombres y ausencia de frases añadidas.
- **Dirección visual:** que el estilo se refleje en la composición y no solo en el color.
- **Fidelidad:** forma y logotipo del producto; piezas y funciones verificadas.
- **Uso real:** encuadre, tamaño de archivo y legibilidad en el destino final.

Si una imagen exige letras exactas, genera la base visual y añade el texto en tu editor: el modelo todavía falla con la colocación del texto.