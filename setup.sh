#!/bin/sh
# TODO: 冗長
sed -i -e "s/HATENA_BLOG_DOMAIN/${HATENA_BLOG_DOMAIN}/g" ~/.config/blogsync/config.yaml
sed -i -e "s/HATENA_USER_NAME/${HATENA_USER_NAME}/g" ~/.config/blogsync/config.yaml
sed -i -e "s/HATENA_API_KEY/${HATENA_API_KEY}/g" ~/.config/blogsync/config.yaml
QIITA=${QIITA_API_KEY} qiitaexporter -template blogsync.template
find posts -name "*.md" | xargs -I $ sh -c "blogsync post ${HATENA_BLOG_DOMAIN} < $"
