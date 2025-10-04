// Project name: Aixt, https://github.com/fermarsan/aixt.git
// Author: 
// Date: 2025
// Description: UART functions (WCH-CH32V103)

module uart

@[inline]
pub fn begin(usart &C.USART_TypeDef, baud int) {
    mut init := C.USART_InitTypeDef{
        USART_BaudRate: baud
        USART_WordLength: C.USART_WordLength_8b
        USART_StopBits: C.USART_StopBits_1
        USART_Parity: C.USART_Parity_No
        USART_HardwareFlowControl: C.USART_HardwareFlowControl_None
        USART_Mode: C.USART_Mode_Tx | C.USART_Mode_Rx
    }
    C.USART_Init(usart, &init)
    C.USART_Cmd(usart, C.ENABLE)
}

@[inline]
pub fn write(usart &C.USART_TypeDef, b u8) {
    C.USART_SendData(usart, b)
    for C.USART_GetFlagStatus(usart, C.USART_FLAG_TXE) == 0 {}
}

@[inline]
pub fn print(usart &C.USART_TypeDef, s string) {
    for c in s.bytes() {
        write(usart, c)
    }
}

@[inline]
pub fn read(usart &C.USART_TypeDef) u8 {
    for C.USART_GetFlagStatus(usart, C.USART_FLAG_RXNE) == 0 {}
    return u8(C.USART_ReceiveData(usart) & 0xFF)
}