# Установка продукта
- На удаленном сервере должны быть установлены ruby 2.1.2, база данных MySQl и rvm.
- На локальном компьютере нужно развернуть проект и выполнить bundle install
- В файле ```config/deploy.rb``` прописать необходимые параметры подключения к удаленному серверу
- Запустить на локальном компьютере ```cap deploy:setup```.
- На удаленном сервере в папку ```/home/#{user}/projects/#{application}/shared``` положить ```database.yml```, ```secrets.yml```, ```mail.yml``` и ```thin.yml```
- На локальном компьютере запустить ```cap deploy```

Для работы сайта запускается веб-сервер thin и delayed_job для фоновой отправки имейлов.
