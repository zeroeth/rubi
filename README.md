Rubi. A ruby irc bot
--------------------

Rubi is based on the `cinch` gem which makes creating bots super easy. Supports ssl and sasl authentication out of the box which is super awesome.

Repo is heroku friendly. Copy .env.template to .env and test with foreman start. Set heroku vars to match and don't forget to ps:scale app=1 or else it will never run.

### Deploy

	git clone https://github.com/zeroeth/rubi.git
    cd rubi
    cp .env.template .env
    # (edit values)
    heroku apps:create
    heroku plugins:install git://github.com/ddollar/heroku-config.git
    git push heroku master
    heroku config:push
    heroku ps:scale app=1
    heroku logs --tail