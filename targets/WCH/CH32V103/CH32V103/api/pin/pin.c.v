// Project name: Aixt, https://github.com/fermarsan/aixt.git
// Author: 
// Date: 2025
// Description: PIN functions (WCH-CH32V103)

module pin

// Modos posibles para un pin
pub enum PinMode {
    input
    output
}

// Configura el modo de un pin
@[inline]
pub fn mode(port &C.GPIO_TypeDef, pin u16, mode PinMode) {
    mut gpio = C.GPIO_InitTypeDef{}
    gpio.GPIO_Pin = pin
    match mode {
        .input {
            gpio.GPIO_Mode = C.GPIO_Mode_IN_FLOATING
        }
        .output {
            gpio.GPIO_Mode = C.GPIO_Mode_Out_PP
            gpio.GPIO_Speed = C.GPIO_Speed_50MHz
        }
    }
    C.GPIO_Init(port, &gpio)
}

// Escribe HIGH o LOW según un bool
@[inline]
pub fn write(port &C.GPIO_TypeDef, pin u16, state bool) {
    if state {
        C.GPIO_SetBits(port, pin)     // HIGH
    } else {
        C.GPIO_ResetBits(port, pin)   // LOW
    }
}

// Fuerza el pin a HIGH
@[inline]
pub fn high(port &C.GPIO_TypeDef, pin u16) {
    C.GPIO_SetBits(port, pin)
}

// Fuerza el pin a LOW
@[inline]
pub fn low(port &C.GPIO_TypeDef, pin u16) {
    C.GPIO_ResetBits(port, pin)
}
