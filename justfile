docs:
  swift package \
  --allow-writing-to-directory ./docs \
  generate-documentation \
  --target Thundering \
  --output-path ./docs \
  --transform-for-static-hosting \
  --hosting-base-path thundering

