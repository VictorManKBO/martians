unit gamelib;
interface
uses crt,dos;
type
  bot0=record
      place:array[1..2]of byte;
      dead:boolean;
     end;

  bots=record
      shot:array[1..50,1..24]of boolean;
      bot:array[1..10]of bot0;
     end;

  Headbot=record
      x,dx:integer;
      dead:boolean;
      life:byte;
      shot1:array[1..50,1..23]of boolean;
     end;
  ScoreType=record
       name:string[10];
       point:longint;
     end;
   tableOfScore=array[1..11]of scoretype;

  game=object
  public
    procedure init;
    procedure cursoroff;
    procedure wall(point:longint;level,life_hbot:byte);
    end;

implementation
procedure game.init;
  begin
       textbackground(blue);
	   clrscr;
       textcolor(white);
  end;
procedure game.cursoroff;
var reg:registers;
begin
   with reg do begin
        AH:=1;
        CH:=$20;
   end;
   intr($10,reg);
end;

procedure game.wall(point:longint;level,life_hbot:byte);
var i,procentHP:byte;
begin
     window(51,1,52,25);
     for i:=1 to 24 do writeln(#222);
     write(#222);

     window(53,1,80,10);
     writeln('Счёт:',point:9);
     if level=200
     then begin
              writeln('Уровень: Босс');
              procenthp:=(life_hbot*100) div 20;
              write('Hp Босса ',procenthp,'% ');
          end
     else begin writeln('Уровень: ',level,'   ');clreol;end;
end;
end.