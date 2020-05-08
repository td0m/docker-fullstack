FROM node:12.16.1-alpine3.11 AS JS_BUILD
COPY web /web
WORKDIR web
RUN npm install && npm run build

FROM golang:1.13.9-alpine AS GO_BUILD
COPY server /server
WORKDIR /server
RUN go build -o /go/bin/server

FROM alpine:3.11.3
COPY --from=JS_BUILD /web/build* ./web/
COPY --from=GO_BUILD /go/bin/server ./
CMD ./server


