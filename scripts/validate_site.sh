#!/bin/sh
set -eu

expected_name='論理の塔 - LOGIC TOWER'
expected_bundle='com.shiraiaka.logictower'
forbidden_name='ひらめき忍者と 四つの里'

files='index.html support/index.html privacy-policy/index.html index.en.html support/index.en.html privacy-policy/index.en.html'

for file in $files; do
  test -f "$file"
  grep -Fq "$expected_name" "$file"
  if grep -Fq "$forbidden_name" "$file"; then
    echo "ERROR: 別アプリ名が含まれています: $file" >&2
    exit 1
  fi
done

grep -Fq "$expected_name" site-identity.json
grep -Fq "$expected_bundle" site-identity.json
grep -Fq 'Google AdMob' privacy-policy/index.html
grep -Fq 'リワード広告' privacy-policy/index.html
grep -Fq 'App Tracking Transparency' privacy-policy/index.html

echo 'SITE_VALIDATION_PASS / LOGIC TOWER / 6 PAGES'
