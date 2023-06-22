# Stage 1: Build the Go binary
FROM golang:alpine AS builder

WORKDIR /app

COPY main.go go.mod ./
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o main .

FROM scratch

COPY --from=builder /app/main /

ENTRYPOINT ["/main"]
