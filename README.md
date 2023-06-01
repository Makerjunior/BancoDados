# BancoDados
 Mysql-server

 Com esse Dockerfile, a imagem pode ser construída com o seguinte comando na linha de comando:
```
docker build -t my-mysql-image:banco .
```
E depois, um container pode ser iniciado a partir dessa imagem com o seguinte comando:
```
docker run --name my-mysql-container -p 3306:3306 -d my-mysql-image
```
Este comando inicia um novo container chamado my-mysql-container a partir da imagem my-mysql-image, mapeia a porta 3306 do container para a porta 3306 do host e executa o container em segundo plano (-d).
