Курсовой проект по курсу DEVOPS Практики и Инструменты
gcloud init
gcloud auth application-default login
terraform init
terraform apply
docker-compose up -d

kubectl apply -f ./kubernetes

kubectl get svc ui

Необходимо для микросервисного приложения состоящего из фронта, бэка, базы и очереди построить процесс доставки.
Фронт - https://github.com/express42/search_engine_ui
Бэк - https://github.com/express42/search_engine_crawler
База - MongoDB https://www.mongodb.com/
Очередь - RabbitMQ https://www.rabbitmq.com/

К MVP было сделано:
1. Написаны terraform файлы для создания кластера kubetnetes в GKE. Для запуска необходимо из папки terraform выполнить terraform apply.
2. Написаны Dockerfile для приложений search_engine_ui и search_engine_crawler.
3. Написан docker-compose файл для локального разворачивания и тестирования приложения. Для запуска необходимо из папки docker выполнить docker-cimpose up -d. Приложение будет доступно по адресу http://localhost:8000.
4. Написаны манифесты для создания объектов namespace, deployment, service в kubernetes для приложения и сопутствующих компонентов.
5. Через helm chart установлены prometheus для мониторинга и grafana для визуализации метрик.
6. На текущий момент процесс доставки приложения описан в deploy.sh. После выполнения ./deploy.sh из корня папки поднимается кластер k8s в gke, создаются объекты в k8s, устанавливается prom и grafana. После выполнения всех шагов скрипта в консоли будут выведены адреса для доступа к web приложения, к grafana и prometheus.

Планируется сделать к защите проекта:
1. Перенести шаги из bash скрипта в GitHub Actions.
2. Добавить шаг сборки контейнеров.
3. Добавить шаг тестирования.
4. Добавить логирование и трассировки.