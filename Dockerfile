FROM nginx:alpine
RUN apk add --no-cache xz
COPY parts/ /tmp/parts/
RUN cat /tmp/parts/p* | tr -d '\n' | base64 -d | xz -dc > /usr/share/nginx/html/index.html \
 && echo "80e4a2031afcb7bf36679257e93031b397d3fae7cab29c0254f173b2fb9ac58e  /usr/share/nginx/html/index.html" | sha256sum -c - \
 && printf 'User-agent: *\nAllow: /\n' > /usr/share/nginx/html/robots.txt \
 && rm -rf /tmp/parts
EXPOSE 80
