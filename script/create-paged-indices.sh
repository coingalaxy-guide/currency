#!/usr/bin/env bash

repo_path=~/git/coingalaxy.guide/currency
#currencies_path=${repo_path}/index.json
currencies_path=/tmp/coins.json
currency_count=$(jq '.currencies | length' ${currencies_path})

for page_size in {10,20,50,100,200}; do
  mkdir -p ${repo_path}/index/index-${page_size}
  page_count=$((currency_count / page_size))
  echo "currency count: ${currency_count}, page size: ${page_size}, page count: ${page_count}"

  for page_index in $(seq 0 $((page_count - 1))); do
    currency_index_start=$((page_index * page_size))
    currency_index_end=$((currency_index_start + page_size - 1))
    echo "- page index: ${page_index}, currency index start: ${currency_index_start}, currency index end: ${currency_index_end}"
    jq \
      --argjson start ${currency_index_start} \
      --argjson stop $((currency_index_end + 1)) \
      '.currencies[$start:$stop]' \
      ${currencies_path} > ${repo_path}/index/index-${page_size}/page-$((page_index + 1)).json
  done
  echo
done
