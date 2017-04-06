(*
 * Project: lab6
 * User: alexander_sumaneev
 * Date: 05.04.2017
 *)
unit bintree;

interface

type
    PNode = ^Node;
    Node = record
        data: string;
        left, right: PNode;
    end;

    bin_tree = object
    private
        root:PNode;
    public
        procedure insert_tree(numb:string); //вставка элемента в дерево
        procedure print_tree(elem:PNode); //вывести дерево на экран
        procedure delete_tree(elem:PNode); //удалить дерево
        procedure find_tree(numb:string;elem:PNode); //найти элемент в дереве
        constructor create();
        function root_tree():PNode;
    end;

implementation

function bin_tree.root_tree():PNode;
begin
root_tree:=root;
end;

procedure bin_tree.insert_tree(numb:string);
var
    prev_node:PNode; //предыдущий узел дерева
    new_node:PNode;  //новый узел
    curr_node:PNode; //текущий узел
begin
    New(new_node);
    new_node^.data:=numb;
    new_node^.left:=nil; //новый узел будет листом дерева
    new_node^.right:=nil;
    prev_node:=nil;
    curr_node:=root;
    while curr_node<>nil do //пока не дойдем до листа
    begin
        prev_node:=curr_node;
        if curr_node^.data > numb then
            curr_node:=curr_node^.left
        else
            curr_node:=curr_node^.right;
    end;
    if root=nil then //если дерево пустое, то создаем корень
        root:=new_node
    else
        if prev_node^.data > numb then
            prev_node^.left:=new_node
        else
            prev_node^.right:=new_node;
end;

procedure bin_tree.print_tree(elem:PNode);
begin
    if root = nil then
        WriteLn('Empty tree')
    else
    begin
        Writeln(elem^.data,' ');
        if elem^.left<>nil then
            print_tree(elem^.left);
        if elem^.right<>nil then
            print_tree(elem^.right);
    end;
end;

procedure bin_tree.delete_tree(elem:PNode);
begin
    if root <> nil then
    begin
        if elem^.left<>nil then
            delete_tree(elem^.left);
        if elem^.right<>nil then
            delete_tree(elem^.right);
        Dispose(elem);
        elem:=nil;
    end
    else
        WriteLn('Empty tree');
    root:=nil;
end;

procedure bin_tree.find_tree(numb:string;elem:PNode);
begin
    if root = nil then
        WriteLn('Empty tree')
    else
    begin
        if elem^.data = numb then
            Writeln(elem^.data,' ');
        if elem^.left<>nil then
            find_tree(numb,elem^.left);
        if elem^.right<>nil then
            find_tree(numb,elem^.right);
    end;
end;

constructor bin_tree.create();
begin
    root:=nil;
end;

end.