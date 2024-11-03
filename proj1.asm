INCLUDE Irvine32.inc

.data
    menu BYTE "Select an option:", 0
    option1 BYTE "1. Enter a sale.", 0
    option2 BYTE "2. View all sales.", 0
    option3 BYTE "3. View total.", 0
    option4 BYTE "4. Quit.", 0
    addSalePrompt BYTE "Enter sale value: ", 0
    arrayFullMessage BYTE "No more sales can be added.", 0
    noSalesMessage BYTE "No sales have been entered.", 0
    totalMessage BYTE "Total sales: ", 0
    sales DWORD 30 DUP(0)
    numSales DWORD 0
    badInputPrompt BYTE "Please enter a value between 1 and 4.", 0
    period BYTE ". ", 0

.code
startLoop:
    mov edx, OFFSET menu
    call WriteString
    call crlf

    mov edx, OFFSET option1
    call WriteString
    call crlf

    mov edx, OFFSET option2
    call WriteString
    call crlf

    mov edx, OFFSET option3
    call WriteString
    call crlf

    mov edx, OFFSET option4
    call WriteString
    call crlf

    call ReadInt

    cmp eax, 1
    je callAddSale

    cmp eax, 2
    je callViewSales

    cmp eax, 3
    je callTotalSales

    cmp eax, 4
    je handleQuit

    jl badInput
    jg badInput

    jmp startLoop

callAddSale:
    mov ecx, numSales
    mov esi, OFFSET sales
    call addSale
    ; Increment numSales if a sale was added successfully
    cmp ecx, 30
    jae startLoop       ; If the array was full, skip increment
    inc numSales
    jmp startLoop

callViewSales:
    mov ecx, numSales
    mov esi, OFFSET sales
    call viewSales
    jmp startLoop

callTotalSales:
    mov ecx, numSales
    mov esi, OFFSET sales
    call totalSales
    jmp startLoop

addSale PROC USES esi ecx
    cmp ecx, 30
    je fullArray
    mov edx, OFFSET addSalePrompt
    call WriteString
    call ReadDec
    mov [esi + ecx*4], eax
    ret
fullArray:
    mov edx, OFFSET arrayFullMessage
    call WriteString
    call crlf
    ret
addSale ENDP

viewSales PROC USES esi ecx ebx
    cmp ecx, 0
    je noSales
    mov ebx, 0
displayLoop:
    cmp ebx, ecx
    je endLoop
    ; Print line number (ebx + 1)
    mov eax, ebx
    inc eax
    call WriteDec
    mov edx, OFFSET period
    call WriteString
    ; Print sale value at index [esi + ebx * 4]
    mov eax, [esi + ebx*4]
    call WriteDec
    call crlf
    inc ebx
    jmp displayLoop
endLoop:
    ret
noSales:
    mov edx, OFFSET noSalesMessage
    call WriteString
    call crlf
    ret
viewSales ENDP

totalSales PROC USES esi ecx ebx
    cmp ecx, 0
    je noTotal
    mov ebx, 0
    mov eax, 0
totalLoop:
    cmp ebx, ecx
    je endTotalLoop
    add eax, [esi + ebx*4]
    inc ebx
    jmp totalLoop
endTotalLoop:
    mov edx, OFFSET totalMessage
    call WriteString
    mov edx, eax
    call WriteDec
    call crlf
    ret
noTotal:
    mov edx, OFFSET noSalesMessage
    call WriteString
    call crlf
    ret
totalSales ENDP

handleQuit PROC
    exit
handleQuit ENDP

badInput PROC
    mov edx, OFFSET badInputPrompt
    call WriteString
    call crlf
    jmp startLoop
badInput ENDP

END startLoop
