// Project name: Aixt, https://github.com/fermarsan/aixt.git
// Author: 
// Date: 2025
// Description: PWM functions (WCH-CH32V103)

module pwm

// Configura un canal de PWM en un timer específico
@[inline]
pub fn setup(timer &C.TIM_TypeDef, channel int, period u16, pulse u16) {
    mut tim_oc = C.TIM_OCInitTypeDef{}
    mut tim_timebase = C.TIM_TimeBaseInitTypeDef{}

    // Configuración del Timer
    tim_timebase.TIM_Period = period                // periodo del PWM (TOP del contador)
    tim_timebase.TIM_Prescaler = 72 - 1             // prescaler: 72 MHz / 72 = 1 MHz
    tim_timebase.TIM_ClockDivision = 0
    tim_timebase.TIM_CounterMode = C.TIM_CounterMode_Up
    C.TIM_TimeBaseInit(timer, &tim_timebase)

    // Configuración del canal en modo PWM
    tim_oc.TIM_OCMode = C.TIM_OCMode_PWM1           // PWM modo 1
    tim_oc.TIM_OutputState = C.TIM_OutputState_Enable
    tim_oc.TIM_Pulse = pulse                        // ciclo útil inicial
    tim_oc.TIM_OCPolarity = C.TIM_OCPolarity_High

    // Inicializar el canal elegido
    match channel {
        1 { C.TIM_OC1Init(timer, &tim_oc) }
        2 { C.TIM_OC2Init(timer, &tim_oc) }
        3 { C.TIM_OC3Init(timer, &tim_oc) }
        4 { C.TIM_OC4Init(timer, &tim_oc) }
        else {}
    }

    // Habilita el timer
    C.TIM_Cmd(timer, C.ENABLE)
}

// Cambia el ciclo útil (duty cycle) en un canal específico
@[inline]
pub fn set_duty(timer &C.TIM_TypeDef, channel int, duty u16) {
    match channel {
        1 { C.TIM_SetCompare1(timer, duty) }
        2 { C.TIM_SetCompare2(timer, duty) }
        3 { C.TIM_SetCompare3(timer, duty) }
        4 { C.TIM_SetCompare4(timer, duty) }
        else {}
    }
}
