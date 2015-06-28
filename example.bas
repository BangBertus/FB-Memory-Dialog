#include "dialog.bas"

dialog("hello","Tahoma",8,WS_SYSMENU or WS_MINIMIZEBOX or DS_CENTER or DS_SETFONT,_
       0,0,100,80)
control("button","button#1",BS_DEFPUSHBUTTON,4,4,40,16,101)
control("button","button#2",BS_DEFPUSHBUTTON,50,4,40,16,102)
control("button","button#3",BS_DEFPUSHBUTTON,4,24,40,16,103)
control("button","button#4",BS_DEFPUSHBUTTON,50,24,40,16,104)

function proc(hwin As HWND,uMsg As UINT,wParam As WPARAM,lParam As LPARAM)as BOOL
    select case uMsg
     case WM_COMMAND
        MessageBox hwin,"Id : " + str(loword(wparam)),"test",MB_OK
     case WM_CLOSE
        EndDialog( hwin,null)
    end select    
    Return 0
end function 

DialogBoxIndirect(0, cast(any ptr,@mem(0)) ,0, @proc)
