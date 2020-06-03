#!/bin/sh
cat ~/.config/blogsync/config.yaml.tmp | envsubst > ~/.config/blogsync/config.yaml
QIITA=${QIITA_API_KEY} qiitaexporter -template blogsync.template
find posts -name "*.md" | xargs -I $ -P 5 sh -c "blogsync post ${HATENA_BLOG_DOMAIN} < $"
