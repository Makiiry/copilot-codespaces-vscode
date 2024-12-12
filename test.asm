.MODEL SMALL
.STACK 100H

; Se citește de la tastatură un număr zecimal din N cifre terminat cu $. (N<10)
; Să se tipărească numărul de cifre al numărului citit și paritatea sa matematică.
; Ex: 13415$ va tipări Numărul 13415 are 5 cifre, paritate impară.
; Hint: Cifrele se citesc una cîte una.
; Program Assembly pentru determinarea numarului de cifre si a paritatii unui numar citit cifra cu cifra


.DATA
    MESAJ DB 'INTRODUCETI UN NUMAR DE MAXIM 10 CIFRE: $'
    LINIE_NOUA DB 0DH, 0AH, '$'
    NR        DW 257 ;numarul pe care urmeaza sa-l verificam ca paritate matematica
    MSG_PAR   DB 'NR ESTE PAR', 0DH, 0AH, '$'
    MSG_IMPAR DB 'NR ESTE IMPAR', 0DH, 0AH, '$'

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX

    MOV BX, [NR]    ;punem in registrul BX numarul din memorie

    RCR BX, 1       ;rotim prin carry la dreapta binar
                    ;astfel ca bitul care da paritatea matematica va fi pus
                    ;in fanionul carry

    ;incercati si verificarea paritarii folosind AND BX, 01H in loc de rotire si apoi
    ;comparati numarul cu 0 pentru a lua decizia daca e par sau nu

    JC NR_IMPAR     ;verificam paritatea doar prin testarea fanionului carry
    ;daca nu avem carry (bitul 0 a fost 0) atunci numarul e par si continuam imediat mai jos

    MOV DX, OFFSET MSG_PAR  ;stabilim DX ca offset la mesajul de paritate para
    JMP TIPARESTE           ;si sarim direct la tiparire

NR_IMPAR:
    ;daca avem carry (bitul 0 a fost 1) atunci numarul e impar
    ;deci jump-ul va sari aici
    MOV DX, OFFSET MSG_IMPAR    ;stabilim DX ca offset la mesajul de paritate impara

TIPARESTE:
    ;partea de tiparire este comuna pentru ambele cazuri.
    MOV AH, 9
    INT 21H     ;se apeleaza functia 9 pentru tiparire

    MOV AX, 4C00H
    INT 21H
END START
