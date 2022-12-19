FROM golang:1.18-alpine as builder

WORKDIR /ion

COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download

COPY pkg/ pkg/
COPY proto/ proto/
COPY apps/ apps/

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -installsuffix cgo -o /ion/app-room-mgmt ./apps/room-mgmt

FROM alpine

COPY --from=builder /ion/app-room-mgmt /app-room-mgmt

COPY configs/docker/app-room-mgmt.toml /configs/app-room-mgmt.toml

ENTRYPOINT ["/app-room-mgmt"]
CMD ["-c", "/configs/app-room-mgmt.toml"]
