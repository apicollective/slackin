#!/bin/sh

./bin/slackin --port $PORT --hostname 0.0.0.0 $SLACK_SUBDOMAIN $SLACK_API_TOKEN $GOOGLE_CAPTCHA_SECRET $GOOGLE_CAPTCHA_SITEKEY
