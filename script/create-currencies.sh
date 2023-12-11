#!/usr/bin/env bash

repo_path=~/git/coingalaxy.guide/currency
#currencies_path=${repo_path}/index.json
currencies_path=/tmp/coins.json
currency_count=$(jq '.currencies | length' ${currencies_path})

for currency_index in {0..4999}; do
  currency_slug=$(jq -r --argjson i ${currency_index} '.currencies[$i].slug' ${currencies_path})
  echo "currency index: ${currency_index}, currency slug: ${currency_slug}"
  jq \
    --argjson i ${currency_index} \
    '.currencies[$i]' \
    ${currencies_path} \
    > ${repo_path}/currencies/${currency_slug}.json
done
