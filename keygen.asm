.386
.model flat, stdcall
option casemap: none

include G:/Fhantom/lib.inc

include C:/masm32/include/gdi32.inc
includelib C:/masm32/lib/gdi32.lib
 
includelib C:/masm32/lib/user32.lib
includelib C:/masm32/lib/kernel32.lib

.data

hInstance dd ?

hWndEdit HWND ?
hWndEdit2 HWND ?
hWndEdit3 HWND ?
hWndEdit4 HWND ?
hWndEdit5 HWND ?
hWndBtn HWND ?

pass1 db ?
pass2 db ?
pass3 db ?
pass4 db ?

nick dd ?

res dd ?

txtbuff db 255 dup(?)    

ClassMainName db 'test',0
WinMainName db "KeyGen for Zephyrouse's KeygenMe #3",0 ; 

labelType db "static",0
edit db "edit",0
btn db "button",0

labelName db "Enter your name here: ",0
labelPass db "Your key: ",0
labelAuth db "cODEd bY [UltraLazer]",0

genText db "Generate",0
extBtnText db "Exit",0
abtBtnText db "About",0

abtMsgTitle db "About",0
abtMsgText db "KeyGen for FaNtOm's Crackme #4 made by UltraLazer",0

error db "Enter your name please!",0

hfont dd ?

lf LOGFONT <14,5,0,0,0,0,0,0,0,0,0,0,0,'Sans-serif'>                

.const

labelIdName equ 1
labelIdPass equ 2
labelIdAuth equ 3

editName equ 4
editPass1 equ 5
editPass2 equ 6
editPass3 equ 7
editPass4 equ 8

genBtnId equ 9
extBtnId equ 10
abtBtnId equ 11

.code
start:

invoke GetModuleHandle, 0
mov hInstance, eax
invoke WinMain, hInstance,0, 0, 1
invoke ExitProcess, 0

WinMain proc hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
LOCAL wc:WNDCLASSEX
LOCAL msg:MSG
LOCAL hWnd:HWND

    mov wc.cbSize, SIZEOF WNDCLASSEX
    mov wc.style, CS_HREDRAW or CS_VREDRAW
    mov wc.lpfnWndProc, OFFSET WndProc
    mov wc.cbWndExtra, 0
    mov wc.cbClsExtra,DLGWINDOWEXTRA
    mov wc.hbrBackground,COLOR_BTNFACE+1
    mov wc.lpszMenuName, 0
    mov wc.lpszClassName, OFFSET ClassMainName
    invoke LoadIcon, 0, IDI_APPLICATION
    mov wc.hIcon, eax
    mov wc.hIconSm, eax
    invoke LoadCursor, 0, IDC_ARROW
    mov wc.hCursor, eax
    invoke RegisterClassEx, addr wc

    INVOKE CreateWindowEx,0,addr ClassMainName,addr WinMainName,\
    WS_OVERLAPPEDWINDOW-WS_SIZEBOX-WS_MAXIMIZEBOX,CW_USEDEFAULT,\
    CW_USEDEFAULT,430,165,0,0,\
    hInst,0

    mov hWnd, eax

    invoke ShowWindow, hWnd,1
    invoke UpdateWindow, hWnd

    .while TRUE
        invoke GetMessage, addr msg, 0, 0, 0
        .break .if(!eax)
        invoke TranslateMessage, addr msg
        invoke DispatchMessage, addr msg
    .endw
    mov eax, msg.wParam
    ret
WinMain endp

WndProc proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD

.IF uMsg==WM_CREATE   

    invoke CreateFontIndirectA,addr lf
    mov hfont,eax

    invoke CreateWindowEx, 0,addr labelType,addr labelName,WS_CHILD or WS_VISIBLE ,12, 5, 200, 15, hWnd, labelIdName,hInstance, 0 
    invoke SendMessageA,eax,WM_SETFONT,hfont,1
    
    invoke CreateWindowEx,WS_EX_CLIENTEDGE, addr edit,0,WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_AUTOHSCROLL,12,25,300,25,hWnd,editName,hInstance,0
    mov hWndEdit,eax
    invoke SendMessageA,eax,WM_SETFONT,hfont,1
    invoke SetFocus, eax

    invoke CreateWindowEx, 0,addr labelType,addr labelPass,WS_CHILD or WS_VISIBLE ,12, 55, 200, 20, hWnd, labelIdPass,hInstance, 0 
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

    invoke CreateWindowEx,WS_EX_CLIENTEDGE, addr edit,0,WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_READONLY or ES_AUTOHSCROLL,12,75,70,25,hWnd,editPass1,hInstance,0
    mov hWndEdit2,eax
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

    invoke CreateWindowEx,WS_EX_CLIENTEDGE, addr edit,0,WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_READONLY or ES_AUTOHSCROLL,85,75,70,25,hWnd,editPass2,hInstance,0
    mov hWndEdit3,eax
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

    invoke CreateWindowEx,WS_EX_CLIENTEDGE, addr edit,0,WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_READONLY or ES_AUTOHSCROLL,158,75,70,25,hWnd,editPass1,hInstance,0
    mov hWndEdit4,eax
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

    invoke CreateWindowEx,WS_EX_CLIENTEDGE, addr edit,0,WS_CHILD or WS_VISIBLE or WS_BORDER or ES_LEFT or ES_READONLY or ES_AUTOHSCROLL,231,75,70,25,hWnd,editPass3,hInstance,0
    mov hWndEdit5,eax
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

    invoke CreateWindowEx, 0,addr labelType,addr labelAuth,WS_CHILD or WS_VISIBLE ,12, 110, 200, 20, hWnd, labelIdAuth,hInstance, 0 
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

    invoke CreateWindowEx,WS_EX_LTRREADING,addr btn,addr genText,WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,330,15,80,25,hWnd,genBtnId,hInstance,0
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

    invoke CreateWindowEx,WS_EX_LTRREADING,addr btn,addr extBtnText,WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,330,50,80,25,hWnd,extBtnId,hInstance,0
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

    invoke CreateWindowEx,WS_EX_LTRREADING,addr btn,addr abtBtnText,WS_CHILD or WS_VISIBLE or BS_PUSHBUTTON,330,100,80,25,hWnd,abtBtnId,hInstance,0
    invoke SendMessageA,eax,WM_SETFONT,hfont,1

.ELSEIF uMsg==WM_COMMAND
    mov eax,wParam
    .IF lParam==0
    .ELSE
    .IF ax==genBtnId
        shr eax,16
	.IF ax==BN_CLICKED
    
        invoke GetWindowTextLength,hWndEdit
    
        .if al > 0
             
            invoke GetDlgItemText, hWnd, editName, addr nick, 30
            
            call generate
            
            push edx
            
            .if eax > 0
                mov txtbuff,0
                mov res,eax
                invoke SetWindowText,hWndEdit2,addr res
            .else 
                mov txtbuff,0
                mov res,30303030h
                invoke SetWindowText,hWndEdit2,addr res
            .endif
            
            .if ebx > 0
                 mov txtbuff,0
                 mov res,ebx
                 invoke SetWindowText,hWndEdit5,addr res
            .else 
                 mov txtbuff,0
                 mov res,30303030h
                 invoke SetWindowText,hWndEdit5,addr res
            .endif
            
            pop edx
            
            .if edx > 0
                  mov txtbuff,0
                  mov res,edx
                  invoke SetWindowText,hWndEdit3,addr res
            .else
                 mov txtbuff,0
                 mov res,30303030h
                 invoke SetWindowText,hWndEdit3,addr res
            .endif 
                      
            .if edi > 0
                mov txtbuff,0
                mov res,edi
                invoke SetWindowText,hWndEdit4,addr res
            .else 
                mov txtbuff,0
                mov res,30303030h
                invoke SetWindowText,hWndEdit4,addr res
            .endif

            mov txtbuff,0

            mov res,0
            mov nick,0
            
        .else

            ;invoke SetWindowText,hWndEdit2,addr error
             ;invoke SetFocus, editName
        .endif
           
     .ENDIF
     .ELSEIF ax==extBtnId
        shr eax,16
        .IF ax==BN_CLICKED
            invoke PostQuitMessage, 0
        .endif
      .ELSEIF ax==abtBtnId
        shr eax,16
        .IF ax==BN_CLICKED
            invoke MessageBox,0,offset abtMsgText,addr abtMsgTitle,MB_OK
     .ENDIF
     .ENDIF
     .ENDIF
.ELSEIF uMsg==WM_DESTROY
invoke PostQuitMessage, 0
.ELSE
invoke DefWindowProc, hWnd, uMsg, wParam, lParam
.ENDIF
ret
WndProc endp

generate:

    inc eax
    
    mov esi,eax

    xor eax,eax
    xor ecx,ecx
    xor edx,edx
    xor ebx,ebx

    cycle:
    movzx edx,byte ptr nick[eax]
    add edx,ebx
    imul edx,eax
    inc eax
    mov ebx,edx ;возможно придется делать отдельную переменную и хранить в ней 
    cmp eax,esi
    jb cycle

    mov eax,ebx
    movzx eax,al
    
    xor edx,edx

    mov ecx,0Fh
    div ecx
    
    mov esi,edx
    
    xor eax,eax
    xor ecx,ecx
    xor edx,edx
    xor ebx,ebx
    xor edi,edi
    
    cmp esi,1
    jnz first_cycle
    mov eax,313131h
    mov edi,3131h

    ret
    
    first_cycle:
    shl eax,8
    add al,31h
    ;;add cl,2
    inc cl
    cmp ecx,esi
    jz quit
    cmp cl,4
    jnz first_cycle
    
    cmp ecx,esi
    jz quit
    
    second_cycle:
    shl ebx,8
    add bl,32h
    ;add cl,2
    inc cl
    cmp ecx,esi
    jz quit
    cmp cl,8
    jnz second_cycle
    
    ;second_cycle:
    
    cmp ecx,esi
    jz quit
    
    ;;push esi
    
    ;;sub esi,ecx
    
    inc esi

    third_cycle:
    shl edx,8
    add dl,32h
    inc cl
    cmp ecx,esi
    jz quit
    cmp cl,12
    jnz third_cycle
    
    cmp ecx,esi
    jz quit
    
    xor edi,edi
    
    inc esi
    
    fourth_cycle:
    shl edi,8
    add di,32h
    add cl,2
    cmp ecx,esi
    jz quit
    cmp cl,16
    jnz fourth_cycle
    
    cmp ecx,esi
    jz quit
    
    ;jmp 
    
   quit:
   
   ;cmp esi,8
   
   ret
    
end start