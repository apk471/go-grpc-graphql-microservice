FROM golang:1.25-alpine AS build
WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY account account
COPY catalog catalog
COPY order order

RUN go build -o /bin/app ./order/cmd/order

FROM alpine:3.20
RUN apk --no-cache add ca-certificates
WORKDIR /usr/bin
COPY --from=build /bin/app .

EXPOSE 8080
CMD ["app"]
