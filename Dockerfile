FROM golang:1.24 AS builder
WORKDIR /app
COPY go.mod go.sum main.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o go-app main.go

# Run stage
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/go-app .
EXPOSE 8081
CMD ["./go-app"]