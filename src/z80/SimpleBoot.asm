; Boot Simples para Z80 (Modo Simples)
ORG %00000000

; Configuração (do Hardware)
SETUP_MACHINE_Z80:
	LD  B,  %00000000   ; Estado Atual (0 = Ocioso)
 	LD  C,  %00000000   ; Passo Atual (0 = Nenhum)
 	CP  B,  %00000000   ; Comparador do Estado (Caso estiver Ocioso)
  	JR  NZ, CHANGE_STEP ; Muda o Passo (para 1)

; Muda o Passo de Boot
CHANGE_STEP:
	INC B               ; Incrementa o Passo
 	CP  B,  %00000001   ; Comparador de Estado (Caso estiver Ocioso)
	JR  NZ, RAM_SETUP   ; Pula para a Configuração de RAM
 	CP  B,  %00000010   ; Comparador de Estado (Caso estiver no Passo da RAM)
	JR  NZ, ROM_SETUP   ; Pula para a Configuração de ROM

; Configura a Memória RAM
RAM_SETUP:
 	LD  HL, %00001000   ; Registrador HL para o Endereço da Memória RAM
	JP  CHANGE_STEP     ; Muda o Passo

; Configura a Memória ROM
ROM_SETUP:
	LD  HL, %00001001   ; Registrador HL para o Endereço da Memória ROM
 	JP  CHANGE_STEP     ; Muda o Passo

; Termmina o Boot
HALT_BOOT:
	
