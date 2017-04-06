(*
 * Project: lab6
 * User: alexander_sumaneev
 * Date: 05.04.2017
 *)
program main;
uses cmdline,regexpr;
var
    my_cmd: cmd_line;
    RegexObj: TRegExpr;
    s:string;
begin
    my_cmd.create();
    my_cmd.init();
    ReadLn;
end.