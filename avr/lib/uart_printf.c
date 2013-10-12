/*
 * uart printf functions
 * jwc :: jwcxz.com
 */

#include "stdio.h"

#include "config.h"
#include "uart.h"
#include "uart_rb.h"
#include "uart_printf.h"

int uart_printf_putchar(char var, FILE *stream);

static FILE uart_printf_stdout = FDEV_SETUP_STREAM(uart_printf_putchar, NULL, _FDEV_SETUP_WRITE);


void uart_printf_init(void) {
    stdout = &uart_printf_stdout;
}


int uart_printf_putchar(char var, FILE *stream) {
    //if (var == '\n') var = '\n';
    uart_rb_tx(var);
    return 0;
}
