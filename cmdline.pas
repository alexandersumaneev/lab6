(*
 * Project: lab6
 * User: alexander_sumaneev
 * Date: 05.04.2017
 *)
unit cmdline;

interface

type cmd_line = object
private
        cmdstr: string; //строка на экране
        cmd:string; //команда после разбиения строки
        cmd_number:string; //аргумент команды
        symbols: set Of char; //доступные символы для печати
        cmd_list: array[0..4] of string; //список доступных команд
        prev_cmd:string; //предыдущая команда
        procedure arrow_up; //действия при нажатии стрелки вверх
        procedure enter; // при нажатии enter
        procedure tab; //автодополнение команды при нажатии tab
        procedure key_press; //обработка нажатия клавиш
        procedure del_spaces; //удаление лишних пробелов
        procedure help; //вывод справки
        Procedure backspace(); //стираем символ
        procedure split; //разделение команды на слово и число
//----------------------------------------------------------------------------------

public
        constructor create;
        procedure init; //запуск меню
//----------------------------------------------------------------------------------

    end;

implementation

uses regexpr,crt,bintree;

var
    my_tree:bin_tree; //дерево

procedure cmd_line.help();
var
    f:Text;
    s:string;
begin //выводит файл со справкой на экран
    Assign(f,'help.txt');
    Reset(f);
    while not Eof(f) do
    begin
          ReadLn(f,s);
          WriteLn(s);
    end;
    Close(f);
end;


procedure cmd_line.split();
var
    space_pos:Integer;
begin
    WriteLn();
    space_pos:=pos(' ',cmdstr);
    if space_pos <> 0 then //если нашли пробел разбиваем команду на 2 части
    begin
        cmd:=Copy(cmdstr,1,space_pos-1); //сама команда
        cmd_number:=Copy(cmdstr,space_pos+1,Length(cmdstr)); //cmd_number содержит число
        if cmd='insert' then
            my_tree.insert_tree(cmd_number);
        if cmd='find' then
            my_tree.find_tree(cmd_number,my_tree.root_tree());
    end
    else
    begin
        cmd:=cmdstr;
        if cmd='help' then
            help();
        if cmd='print' then
            my_tree.print_tree(my_tree.root_tree());
        if cmd='delete' then
            my_tree.delete_tree(my_tree.root_tree());
    end;
end;

procedure cmd_line.del_spaces();
Var
    RegexObj: TRegExpr;
begin
    RegexObj := TRegExpr.Create;
    RegexObj.Expression:='(^\s*)|(\s*$)/(\s\s)'; //пробелы в начале и в конце
    cmdstr:=RegexObj.Replace(cmdstr,'',false);
    RegexObj.Expression:='\s+'; //лишние пробелы между словами
    cmdstr:=RegexObj.Replace(cmdstr,' ',false);
    RegexObj.Expression:='\s$'; //пробел в конце
    cmdstr:=RegexObj.Replace(cmdstr,'',false);
    RegexObj.Destroy();
end;

procedure cmd_line.tab();
var
    i:Integer;
begin
    del_spaces();
    for i:=0 to 4 do
    begin
        if pos(cmdstr,cmd_list[i]) = 1 then //если нашли команду в списке команд
        begin
            cmdstr:=cmd_list[i]+' ';
            delline;
            gotoxy(1,wherey);
            Write(cmdstr);
            break;
        end;
    end;
end;

procedure cmd_line.enter();
var
    expr:string;
    RegexObj: TRegExpr;
begin
    prev_cmd:=cmdstr;
    del_spaces();
    expr:='^(((help)|(print)|(delete))$)|((insert|find)\s(0|(-(1|2|3|4|5|6|7|8|9)\d*)|(1|2|3|4|5|6|7|8|9)\d*))$';
    RegexObj := TRegExpr.Create;
    RegexObj.Expression := expr;
    If not RegexObj.Exec(cmdstr) Then
    begin //если команда не соответствует регулярному выражению expr
        writeln(#10#13,'Incorrect command    *',cmdstr,'*');
        cmdstr:='';
    end
    Else
    begin
        split();
        cmdstr:='';
        WriteLn();
    end;
    RegexObj.Destroy();
end;

procedure cmd_line.arrow_up(); //выводит предыдущую команду
begin
    cmdstr:=prev_cmd;
    gotoxy(1,wherey);
    clreol;
    write(cmdstr);
end;

Procedure cmd_line.backspace();
Begin
    delete(cmdstr,length(cmdstr),1);
    gotoxy(wherex-1,wherey);
    clreol;
End;

procedure cmd_line.key_press();
var
    key:char;
begin
    if Length(cmdstr) > 80 then //если слишком много вбили в консоль
    begin
        WriteLn(#10#13,'The length of string is 80 characters');
        cmdstr:='';
    end
else
    begin
        key := readkey();
        If (key In symbols) Then
        Begin
            write(key);
            cmdstr := cmdstr+key;
        End;
        If (key=#27) Then //Esc
        Halt();
        If (key=#13) Then
            enter();
        If (key=#9) Then
            tab();
        If (key=#8) Then
            backspace();
        If (key=#0) Then
            Case readkey() Of
            #72: arrow_up();
            End;
        end;
end;

constructor cmd_line.create ;
begin
    cmd_list[0]:='help';
    cmd_list[1]:='insert';
    cmd_list[2]:='print';
    cmd_list[3]:='find';
    cmd_list[4]:='delete';
    symbols:=['a'..'z','0' .. '9',' ','-'];
end;

procedure cmd_line.init();
begin
    help();
    my_tree.create();
    while(true) do
    begin
        key_press();
    end;
end;

end.