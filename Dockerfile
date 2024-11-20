FROM golang:alpine AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o main ./cmd/api/main.go 

FROM scratch AS runner

WORKDIR /app

COPY --from=builder /app/main .

EXPOSE 3000

RUN adduser -D golang

USER golang

CMD ["./main"]