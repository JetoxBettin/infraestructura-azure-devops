Preparación del Entorno

Servidor Local

Se verifica que el servidor cumpla con los requisitos:

Windows Server 2016 o superior

.NET Framework 4.7.1

Firewall configurado

Azure AD

Se verifica que se tengan credenciales de administrador global en Azure AD.

Instalación de Azure AD Connect

Descarga e Instalación

Se descarga e instala Azure AD Connect en el servidor local.

Configuración Inicial

Se configuran las credenciales de Azure AD y AD local.

Sincronización de Identidades

Sincronización de Usuarios y Grupos

Azure AD Connect sincroniza usuarios, grupos y otros objetos de AD local con Azure AD.

Sincronización de Contraseñas

Se habilita la sincronización de hash de contraseñas para permitir el uso de credenciales locales en la nube.

Configuración de Autenticación Única (SSO)

Habilitación de SSO

Se habilita el SSO en Azure AD Connect para permitir el acceso sin necesidad de volver a autenticarse.

Verificación de SSO

Se verifica que los usuarios puedan acceder a aplicaciones en la nube con SSO.

Configuración de Autorización Basada en Roles (RBAC)

Sincronización de Grupos de Seguridad

Los grupos de seguridad de AD local se sincronizan con Azure AD.

Asignación de Roles

Se asignan roles de Azure RBAC a los grupos sincronizados.

Verificación y Monitoreo

Revisión de Sincronización

Se verifica que los usuarios y grupos estén correctamente sincronizados en Azure AD.

Monitoreo de Logs

Se revisan los logs de sincronización en el Synchronization Service Manager.

