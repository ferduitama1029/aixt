// Project name: Aixt, https://github.com/fermarsan/aixt.git
// Author: 
// Date: 2025
// Description: ADC functions (WCH-CH32V103)

module adc

// Configura el ADC en un canal específico
@[inline]
pub fn setup(adc &C.ADC_TypeDef, channel u8) {
    // Selecciona el canal del ADC con tiempo de muestreo (55.5 ciclos)
    C.ADC_RegularChannelConfig(adc, channel, 1, C.ADC_SampleTime_55Cycles5)

    // Habilita el ADC
    C.ADC_Cmd(adc, C.ENABLE)

    // Resetea la calibración previa del ADC
    C.ADC_ResetCalibration(adc)
    // Espera hasta que termine el reset de calibración
    for C.ADC_GetResetCalibrationStatus(adc) != 0 {}

    // Inicia la calibración del ADC
    C.ADC_StartCalibration(adc)
    // Espera hasta que termine la calibración
    for C.ADC_GetCalibrationStatus(adc) != 0 {}
}

// Lee un valor convertido por el ADC
@[inline]
pub fn read(adc &C.ADC_TypeDef) u16 {
    // Inicia una conversión por software
    C.ADC_SoftwareStartConvCmd(adc, C.ENABLE)
    // Espera hasta que el ADC indique fin de conversión (EOC)
    for C.ADC_GetFlagStatus(adc, C.ADC_FLAG_EOC) == 0 {}
    // Devuelve el valor leído (0–4095 en 12 bits)
    return C.ADC_GetConversionValue(adc)
}
