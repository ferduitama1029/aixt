// Project name: Aixt, https://github.com/fermarsan/aixt.git
// Author: 
// Date: 2025
// Description: TIME functions (WCH-CH32V103)

module time

@[inline]
pub fn delay(ms u32) {
    C.Delay_Ms(ms)
}

@[inline]
pub fn delay_us(us u32) {
    C.Delay_Us(us)
}
