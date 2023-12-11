#!/usr/bin/env bash

cmc_api_key=$(pass coinmarketcap/api-key)

curl \
  -H "X-CMC_PRO_API_KEY: ${cmc_api_key}" \
  -H "Accept: application/json" \
  -d "start=1&limit=5000&convert=USD" \
  -G https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest \
  | jq . > /tmp/cmc.json

jq '{
    currencies: [
      .data[] | {
        name: .name,
        slug: .slug,
        symbol: (.symbol|ascii_downcase),
        stats: {
          contributors: 0,
          dependents: 0,
          forks: 0,
          commits: 0
        }
      }
    ]
  }' /tmp/cmc.json > /tmp/coins.json
