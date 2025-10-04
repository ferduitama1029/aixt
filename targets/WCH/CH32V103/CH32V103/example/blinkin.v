module main

import time
import c.ch32v10x.gpio

fn setup() {
    gpio.pin_mode(.pc13, .output)   // Configura PC13 como salida
}

fn loop() {
    gpio.write_pin(.pc13, false)    // LED encendido
    time.sleep_ms(500)
    gpio.write_pin(.pc13, true)     // LED apagado
    time.sleep_ms(500)
}

fn main() {
    setup()
    for {
        loop()
    }
}

