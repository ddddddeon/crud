FROM golang:1.16-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY src/main.go ./

RUN go build -o ./crud-app

CMD ["./crud-app"]