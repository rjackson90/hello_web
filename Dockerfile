FROM rust:1 as build
WORKDIR /usr/src

COPY . .
RUN cargo build --release

FROM ubuntu:latest as run
WORKDIR /usr/bin
COPY --from=build /usr/src/target/release/hello_web .

CMD ["hello_web"]

