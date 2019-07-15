**Pre-requirements**
* ruby 2.4.0

**Install**

* `bundle install`
* get twilio account credentials(`accound sid` and `auth token`) here https://www.twilio.com/console/project/settings. Then put them in settings.yml under `twilio/sid` and `twilio/secret`
* create twilio sms service at https://www.twilio.com/console/sms/services
* get service sid and put it in settings.yml, under `twilio/sms_service_sid`
* create a redshift cluster
* open query editor and create a new database with this query from the file `redshift.sql`
* put database credentials(`host, port, database name, database user, password`) in settings.yml

**Run locally**

`bundle exec rackup config.ru -p 3000`

**deploy on heroku**

* create a heroku app
* push code to branch master of heroku repo

**test sending sms**
* `chmod +x ./send_test_message`
* `./send_test_message`