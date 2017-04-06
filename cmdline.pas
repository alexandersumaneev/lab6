(*
 * Project: lab6
 * User: alexander_sumaneev
 * Date: 05.04.2017
 *)
unit cmdline;

interface

type cmd_line = object
private
        str: string; //строка на экране
        cmd:string; //команда после разбиения строки
        number:Integer; //аргумент команды
        i_cmd:Integer; // номер команды в i_cmd_list
        i_fill:Integer; // количество заполненных элементов в i_cmd_list
        i_arrow:Integer; // номер команды в i_cmd_list при нажатии стрелки вверх
        cmd_list: array[0..4] of string; //список доступных команд
        i_cmd_list: array[0..4] of string;//список 5 последних введенных команд
        procedure arrow_up; //действия при нажатии стрелки вверх
        procedure enter; // при нажатии enter
        procedure tab; //автодополнение команды при нажатии tab
        procedure key_press; //обработка нажатия клавиш
        procedure del_spaces; //удаление лишних пробелов
        procedure help; //вывод справки
        function validation:Boolean; //проверка команды на корректность

public
        constructor create;
        procedure init; //запуск меню
end;

implementation

uses bintree,crt,regexpr;

procedure cmd_line.help();
begin

end;


function cmd_line.validation():Boolean;
begin
    validation:=true;
end;

procedure cmd_line.del_spaces();
begin
end;

procedure cmd_line.tab();
begin
end;

procedure cmd_line.enter();
begin
end;

procedure cmd_line.arrow_up();
begin
end;

procedure cmd_line.key_press();
begin
end;

constructor cmd_line.create ;
begin
    cmd_list[0]:='help';
    cmd_list[1]:='insert';
    cmd_list[2]:='print';
    cmd_list[3]:='find';
    cmd_list[4]:='delete';
    i_arrow:=0;
    i_cmd:=0;
    i_fill:=0;

end;

procedure cmd_line.init();
begin

end;

end.