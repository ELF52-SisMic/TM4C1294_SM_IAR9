#include <stdio.h>
#include <stdint.h>

// This example application is intended to be used with the IAR EWARM simulator
// for interrupt handling analysis. NMI and SysTick interrupt requests are
// simulated and therefore there is no need to initialize the hardware. This is
// NOT a suitable example for hardware debugging using real interrupts.

// Simulated frequency should be set to 120MHz
// Interrupt configuration should initially enable SysTick interrupts only
// - SysTick: First Activation = 12000000, Repeat Interval = 12000000
// - NMI:     First Activation = 1,        Repeat Interval = 0

void SysTick_Handler(void){
  printf("\nSysTick_Handler\n"); 
} // SysTick_Handler

void main(void){
  uint32_t a;
  while(1){
    printf(".");
    for(a = 0; a < 100000; a++);
  } // while
} // main