## Instrucciones de instalacion de nagios con docker

## Clonar repositorio

Utilizando el siguiente comando se clona el repositorio:

```sh
git clone https://github.com/Cmonte2023/repo.git
```

## Construcción de imagen del repositorio 

```sh
cd repo
```

```sh
docker build -t lab-virtualizacion .
```

## Ejecucion del contenedor

```sh
docker run -d -p 80:80 lab-virtualizacion
```

## Ingresar

Credenciales:
```sh
Usuario: cmonte
Clave: Duoc.2024
```

Utiliza tu ip publica en "http://x-x-x-x/nagios/" 
