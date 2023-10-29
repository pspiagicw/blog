FROM klakegg/hugo as builder

COPY . /src
WORKDIR /src

RUN hugo

FROM --platform=linux/arm64 busybox:latest

RUN adduser -D static
USER static
WORKDIR /home/static

COPY --from=builder /src/public .

CMD ["busybox", "httpd", "-f", "-v", "-p", "4000"]
