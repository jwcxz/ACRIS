/* A C R I S   P R O J E C T ********
 * LED Controller                   *
 * http://jwcxz.com/projects/acris  *
 *                                  *
 * J. Colosimo -- http://jwcxz.com/ *
 *                                  *
 * UART interface                   *
 ************************************/

#include "main.h"
#include <avr/eeprom.h>

void uart_init(void);
uint8_t uart_rx(void);
uint8_t uart_data_rdy(void);
/* XXX: enable with TX
void uart_tx(uint8_t);
*/
