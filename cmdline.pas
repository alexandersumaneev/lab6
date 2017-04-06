(*
 * Project: lab6
 * User: alexa
 * Date: 05.04.2017
 *)
unit cmdline;

interface

type cmd_line = object
private
        str: string;
        cmd:string;
        number:Integer;
        i_cmd:Integer;
        i_fill:Integer;
        i_arrow:Integer;
        cmd_list: array[1..5] of string;
        procedure arrow_up;
        procedure enter;
        procedure tab;
        procedure key_press;
        procedure del_spaces;
        function validation:Boolean;

public
        constructor create;
        procedure init;
end;

implementation

uses bintree,crt,regexpr;

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
    cmd_list[1]:='help';
    cmd_list[2]:='insert';
    cmd_list[3]:='print';
    cmd_list[4]:='find';
    cmd_list[5]:='delete';

end;

procedure cmd_line.init();
begin

end;

end.