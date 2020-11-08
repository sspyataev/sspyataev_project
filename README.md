Курсовой проект по курсу DEVOPS Практики и Инструменты
======================================================

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

[X] Перенести шаги из bash скрипта в GitHub Actions.

[X] Добавить шаг сборки контейнеров.

[X] Добавит тестирование.

[X] Добавить алертинг.

[X] Записать скринкаст.

Для запуска проекта через Github Actions необходимо в Github Secrets создать следующие секреты:
Для возможности отправить образ в регистри dockerhub необходимы логип и персональный токен dockerhub:
1. DOCKERHUB_USERNAME
2. DOCKERHUB_TOKEN
Для разворачивания кластера используется Terraform Cloud, для связи Github и Terraform используется персональный токен
3. TF_API_TOKEN
Для управления кластером необходим GCP service account key. Подробнее https://github.com/GoogleCloudPlatform/github-actions/tree/docs/service-account-key/setup-gcloud#inputs. JSON-файл с ключом необходимо перевести в строку:
cat sa_key.json | jq -c. 
4. GKE_SA_KEY
5. GKE_PROJECT - id проекта в GCP

Запуск Actions происходит при пуше в репозиторий.
В процессе выполнения workflow собираются образы с приложением, образы пушатся в DockerHub.
Через Terraform разворачивается кластер GKE в GCP.
Последний джоб ждёт выполенения первых двух и после этого создаются объекты в GKE и разворачивается приложение.
