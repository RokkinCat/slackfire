# SlackFire

This is a ruby event machine to accept real time events from firebase, and
shove them into a slack chat via slack's incoming webhook integration.

## Usage
```bash
git clone https://github.com/RokkinCat/slackfire.git
cd slackfire
bundle install
foreman start
```

You'll need to keep the process running actively to allow messages to flow.
