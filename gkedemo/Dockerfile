FROM golang:alpine AS builder
WORKDIR /gkedemo
COPY . .
RUN CGO_ENABLED=0 go build -o gkedemo

FROM scratch
COPY --from=builder /gkedemo/gkedemo /gkedemo
CMD ["/gkedemo"]