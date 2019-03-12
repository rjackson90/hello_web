extern crate actix_web;
extern crate pretty_env_logger;
#[macro_use] extern crate log;

use actix_web::{server, App, HttpRequest, Responder};


fn greet(req: &HttpRequest) -> impl Responder {
    let to = req.match_info().get("name").unwrap_or("World");
    let response = format!("Hello {}!", to);
    info!("Did a thing! In({}) -> Out({})", to, response);
    response
}

fn healthz(_req: &HttpRequest) -> impl Responder {
    "Ok"
}

fn main() {
    pretty_env_logger::init();

    warn!("Starting web server");
    server::new(|| {
        App::new()
            .resource("/healthz", |r| r.f(healthz))
            .resource("/", |r| r.f(greet))
            .resource("/{name}", |r| r.f(greet))
    })
    .bind("127.0.0.1:8000")
    .expect("Can not bind to port 8000")
    .run();
    info!("Server shut down");
}
