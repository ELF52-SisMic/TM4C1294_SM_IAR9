        PUBLIC  __iar_program_start
        PUBLIC  __vector_table

        SECTION .text:CODE:REORDER(2)
        
        ;; Keep vector table even if it's not referenced
        REQUIRE __vector_table

        THUMB
        
__iar_program_start
        
        ;; main program begins here
main
        LDR R0, =ROM32 ; ponteiro de origem
        LDR R1, =RAM32 ; ponteiro de destino
        MOV R2, #16    ; número de elementos
volta   CBZ R2, theend
        SUB R2, R2, #1
        LDR R3, [R0, R2, LSL #2] ; leitura
        STR R3, [R1, R2, LSL #2] ; escrita
        B volta
theend  B .
        ;; main program ends here


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; seção de constantes em ROM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        SECTION .rodata:CONST(2)
        DATA
ROM32   DC32 16, 17, 18, 19, 20, 21, 22, 23
        DC32 24, 25, 26, 27, 28, 29, 30, 31
ROM16   DC16 -1, -2, -3, -4
ROM08   DC8  "Sistemas Microcontrolados"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; seção de variáveis não inicializadas em RAM
;; ver arquivo de configuração do linker (my_cortex.icf)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

        ASEGN .bss:DATA(2),0x20000000 ; início da RAM
        DATA
RAM32   DS32 16
RAM16   DS16  4
RAM08   DS8  26
        
        ;; Forward declaration of sections.
        SECTION CSTACK:DATA:NOROOT(3)
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Interrupt vector table.
;;

        SECTION .intvec:CODE:NOROOT(2)
        
        DATA

__vector_table
        DCD     sfe(CSTACK)
        DCD     __iar_program_start

        DCD     NMI_Handler
        DCD     HardFault_Handler
        DCD     MemManage_Handler
        DCD     BusFault_Handler
        DCD     UsageFault_Handler
        DCD     0
        DCD     0
        DCD     0
        DCD     0
        DCD     SVC_Handler
        DCD     DebugMon_Handler
        DCD     0
        DCD     PendSV_Handler
        DCD     SysTick_Handler

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Default interrupt handlers.
;;

        PUBWEAK NMI_Handler
        PUBWEAK HardFault_Handler
        PUBWEAK MemManage_Handler
        PUBWEAK BusFault_Handler
        PUBWEAK UsageFault_Handler
        PUBWEAK SVC_Handler
        PUBWEAK DebugMon_Handler
        PUBWEAK PendSV_Handler
        PUBWEAK SysTick_Handler

        SECTION .text:CODE:REORDER:NOROOT(1)
        THUMB

NMI_Handler
HardFault_Handler
MemManage_Handler
BusFault_Handler
UsageFault_Handler
SVC_Handler
DebugMon_Handler
PendSV_Handler
SysTick_Handler
Default_Handler
__default_handler
        CALL_GRAPH_ROOT __default_handler, "interrupt"
        NOCALL __default_handler
        B __default_handler

        END
