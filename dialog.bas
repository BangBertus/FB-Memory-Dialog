#include once "windows.bi"
#include once "win\commctrl.bi"
#include once "win\richedit.bi"

dim shared as WORD mem(1024)
dim shared as uinteger count = 11

sub add_str(src as string)
    for i as integer = 0 to len(src)-1
      mem(count+i) = src[i]
    next
    count += len(src)+1
end sub

sub dialog(title as string,fnt as string,fs as WORD ,style as DWORD,_
           x as WORD,y as WORD,w as WORD,h as WORD,xstyle as DWORD = 0)
    ''''''''''''''''''''
    mem(0)= loword(style)
    mem(1)= hiword(style)
    mem(2)= loword(xstyle)
    mem(3)= hiword(xstyle)
    'skip 4 cdit
    mem(5)= x
    mem(6)= y
    mem(7)= w
    mem(8)= h 
    'sip 9-10
    add_str(title)
    if style And DS_SETFONT Then
      mem(count) = fs 'font size
      count += 1
      add_str(fnt) 'font name
    end if
    ''''''
end sub

sub control(clsname as string,title as string,style as DWORD,x as WORD,_
            y as WORD,w as WORD,h as WORD,id as WORD,xstyle as DWORD = 0)
   ''''''''''''''''''''''''''''''
   if count mod 2 then count += 1 'fix alignment
   style = style or WS_CHILD Or WS_VISIBLE
   mem(count) = loword(style)
   mem(count +1)= hiword(style)
   mem(count +2)= loword(xstyle)
   mem(count +3)= hiword(xstyle)
   mem(count +4)= x
   mem(count +5)= y
   mem(count +6)= w
   mem(count +7)= h
   mem(count +8)= id
   count += 9
   add_str(clsname)
   add_str(title)
   count += 1 'skip creation data
   mem(4)+= 1 'update cdit
   ''''''''''
end sub

sub InitCommonControls
    dim as INITCOMMONCONTROLSEX icc
    icc.dwSize = sizeof(INITCOMMONCONTROLSEX)
    icc.dwICC = ICC_ANIMATE_CLASS Or ICC_BAR_CLASSES _
                Or ICC_COOL_CLASSES Or ICC_DATE_CLASSES _
                Or ICC_HOTKEY_CLASS Or ICC_INTERNET_CLASSES _
                Or ICC_LISTVIEW_CLASSES Or ICC_PAGESCROLLER_CLASS _
                Or ICC_PROGRESS_CLASS Or ICC_TAB_CLASSES _
                Or ICC_TREEVIEW_CLASSES Or ICC_UPDOWN_CLASS _
                Or ICC_USEREX_CLASSES Or ICC_WIN95_CLASSES
    InitCommonControlsEx(@icc)
end sub
'''''''
