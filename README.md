![homebrew-ledger](./public/images/homebrew-ledger.png)
# homebrew-ledger
A small web app to help store and track homebrew recipes.

If you are someone who likes to homebrew beer and would like a convenient place to store, edit, and track your recipes, this tool is for you. It can also be used by others to store and share their recipes, too!

# Installation
In order to get started, clone this repository.

Navigate to the `homebrew-ledger` directory and run:
```
bundle install
```
We need to set up a [session secret](https://martinfowler.com/articles/session-secret.html). Create a `.env` file:
```
touch .env
```
Then generate a random secret:
```
ruby -e "require 'securerandom'; puts SecureRandom.hex"
```
Paste the output of the above command into your `.env` file and assign it to a `SESSION_SECRET` variable, **without quotes**, e.g.:
```
SESSION_SECRET=7b49a653d252d97eb156f7ee0409c5c8
```
After that, we can set up our database. To initialize the database, run:
```
rake db:migrate
```
To load the database with some common beer ingredients, run:
```
rake db:load
```
This list of ingredients is sourced by the wonderful folks over at [Brew Cabin](https://www.brewcabin.com/malted-barley/). Check them out!

Whew. Now, we can start the web server. Run:
```
rackup
```
This will start a web server that you can visit at [http://localhost:9292/](http://localhost:9292/). You're good to go!

# Contributing
If you'd like to change the code locally, run the server with `shotgun` rather than `rackup`. This will make sure that your changes are loaded every time you visit a page within the app.

Pull requests are not only welcome, they're encouraged! For major changes, please open an issue first to discuss what you would like to change.

# License
[MIT](./LICENSE)
