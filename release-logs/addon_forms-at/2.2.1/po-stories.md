# PO Stories — WPForms Airtable 2.2.1

## Issues Reviewed

- WPFAT-32: Readme
- WPFAT-33: New Strings to translate
- WPFAT-34: Update WordPress 7.0
- WPFAT-35: Fatal Error on Plugin install

## Issues Updated

- WPFAT-32: Descripción era null — reescrita con user story, scope, criterios de aceptación y open questions sobre la versión exacta de WP y el changelog a incluir.
- WPFAT-33: Era una línea con solo un enlace a Notion — reescrita con user story completa, scope de auditoría de strings i18n, criterios de aceptación y open questions sobre si realmente hay nuevos strings en 2.2.1.
- WPFAT-34: Descripción vacía — reescrita con user story de compatibilidad WP 7.0, criterios de aceptación funcionales, entorno de testing y open questions sobre el estado de lanzamiento de WP 7.0.
- WPFAT-35: Tenía logs de error crudos sin estructura — reescrita con user story, contexto del ticket de soporte (Gleap #209), dos root causes identificados (loadtextdomain demasiado temprano + dynamic properties PHP 8.2), archivos y líneas específicas a corregir, y open questions sobre el alcance del fix.

## Issues Left Unchanged

(ninguno — todos los issues necesitaban refinamiento)

## Open Questions Added

- WPFAT-32: ¿Qué versión exacta de WP usar en `Tested up to`? ¿Qué cambios de 2.2.1 listar en el changelog?
- WPFAT-33: ¿Hay realmente nuevos strings en 2.2.1 o es un chequeo preventivo? ¿El language pack se actualiza en el mismo paso o es un proceso separado?
- WPFAT-34: ¿WordPress 7.0 ya fue lanzado o apunta a un release candidate? ¿Hay breaking changes conocidos de WP 7.0 para este plugin?
- WPFAT-35: ¿Hay otras clases con dynamic properties? ¿`$type`, `$slug`, `$api_url` vienen de argumentos del constructor o de constantes? ¿El text domain se carga en el main file o en una clase bootstrap?

## Summary

Los 4 issues del proyecto "WPForms Airtable v2.2.1" tenían descripciones vacías, de una sola línea o no estructuradas. Todos fueron reescritos con user story, contexto, scope, criterios de aceptación, notas técnicas, notas de testing y open questions. El issue más crítico (WPFAT-35) tenía información técnica útil en forma de logs crudos que fue preservada y estructurada en un brief accionable para el desarrollador, identificando los dos root causes y los archivos exactos a modificar.
