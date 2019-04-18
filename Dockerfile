FROM rust:1 as build

WORKDIR /usr/local/src
RUN apt-get update && apt-get install -y musl-tools
RUN rustup target add x86_64-unknown-linux-musl

COPY Cargo.toml .
COPY Cargo.lock .
COPY src src
RUN cargo build --release --target x86_64-unknown-linux-musl

FROM alpine:latest as run
WORKDIR /usr/local/bin
COPY --from=build /usr/local/src/target/x86_64-unknown-linux-musl/release/hello_web . 

ENV RUST_LOG=info
EXPOSE 8000
CMD ["hello_web"]
