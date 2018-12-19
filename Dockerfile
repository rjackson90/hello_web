FROM rust:1
WORKDIR /src

COPY . .
RUN cargo build --release 

CMD ["target/release/hello_web"]

