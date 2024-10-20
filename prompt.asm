Include Irvine32.inc
; Write a program that asks the user to enter a number and then prints it out.
; Next, ask the user to enter a string and then print it out. 

.data
	numberPrompt BYTE "Enter a number: ", 0
	stringPrompt BYTE "Enter a string: ", 0
	numberInput SDWORD ?
	stringInput BYTE 21 DUP(0)


.code
main PROC
	mov edx, OFFSET stringPrompt
	call WriteString

	mov edx, OFFSET stringInput
	mov ecx, SIZEOF stringInput
	call ReadString
	call WriteString

	call crlf

	mov edx, OFFSET numberPrompt
	call WriteString

	call ReadDec
	call WriteDec

	exit
main ENDP
END main
