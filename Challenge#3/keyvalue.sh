#!/bin/bash

get_nested_value() {
  local json="$1"
  local key="$2"


  IFS="/" read -ra keys <<< "$key"

  local result="$json"


  for k in "${keys[@]}"; do
    result=$(echo "$result" | jq -r ".$k")

    if [ "$result" == "null" ]; then
      echo "Key not found"
      exit 1
    fi
  done

  echo "$result"
}


json='{"x": {"y": {"z": "d"}}}'
key="x/y/z"
value=$(get_nested_value "$json" "$key")
echo "Value: $value"