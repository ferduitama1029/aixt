module main

import time
import c.ch32v10x.adc

fn setup() {
    adc.init()   // Inicializa ADC
}

fn loop() {
    val := adc.read(.pa0)   // Lee canal PA0
    println("Lectura ADC: ${val}")
    time.sleep_ms(500)
}

fn main() {
    setup()
    for {
        loop()
    }
}

