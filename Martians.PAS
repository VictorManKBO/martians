program martianIN;
uses crt,gamelib,botlib,chellib,head_botlib;

var deadc,start:boolean;
    point:longint;
    god:boolean;
    t:bot;
    c:chel;
    g:game;
    hb:head_bot;

label  return,new_game,men;

procedure ClearBuffer;
var ch: char;
begin
   while keypressed do ch:=readkey;
end;

procedure help;
begin
     window(2,7,49,25);
     clrscr;
     writeln('��ࠢ����� ��ࠡ�� �����⢫���� �����蠬�');
     writeln('"�����" � "����" ᮮ⢥��⥭��.������ "�஡��"');
     writeln('�����⢫�� ����५ ��襣� ��ࠡ��. ��㧠');
     writeln('�����⢫���� ����⨥� ������ "�" �� �६�');
     writeln('����. ���-���� �������� �� �६� ���� ����⨥�');
     writeln('��।��񭭮�� ����� ������. ���⭮� ����!');
     writeln('       ');

      write('��� �த������� ������ ���� ������');
      textcolor(white);
      repeat

      until keypressed;
      clrscr;
     ClearBuffer;

end;




procedure Score(var a:TableOfScore;x,y:char);
var f:text;
    i,j,min:byte;
    temp:scoretype;
begin
     for i:=1 to 10 do
     begin
          min:=i;
          for j:=i+1 to 11 do
            if a[j].point>a[min].point then min:=j;
          temp:=a[i];a[i]:=a[min];a[min]:=temp;
     end;


     assign(f,'table_score.txt');

     case x of
      'w':begin
              rewrite(f);
              if y='f'
              then  for i:=1 to 10 do writeln(f,a[i].point,' ',a[i].name)
              else if y='s'
                   then begin
                      window(2,1,49,25);
                      clrscr;
                      writeln('    �窨  ','��� ��ப�');
                      for i:=1 to 10 do writeln(a[i].point:9,' ',a[i].name);
                      window(24,14,49,17);
                      write('��� �த������� ������� ���� ������');

                      repeat

                      until keypressed;
                      clearBuffer;
                      window(1,1,49,25);
                      clrscr;
                   end;
          end;
      'r':begin
              reset(f);
              for i:=1 to 10 do
              begin
                    read(f,a[i].point,a[i].name);
                    delete(a[i].name,1,1);
              end;
          end;

     end;
    close(f);
end;

function menu:byte;
var ch:char;
    y:byte;
begin
      window(20,10,49,25);
      if start then writeln('   �த������')
      else writeln;
      writeln('   ����� ���');
      writeln('      ����');
      writeln('     ������');
      writeln(' ��室 � windows');
      gotoxy(15,15);
      write('By Grinevich V.S');

      window(19,10,20,14);
      y:=11;
      repeat
           clrscr;
           gotoxy(1,y-9);
           write('*');

           ch:=readkey;
           if ch=#0 then ch:=readkey;
           case ch of
             #72:if (y>10)then dec(y);
             #80:if (y<14)then inc(y);
           end;
           if (start=false)and(y=10)then inc(y);
      until ch=#13;
      menu:=y;
end;

procedure chit_god;
var ch:char;
begin
     ch:=readkey;
     if (ch='o')or(ch='O')
     then begin
               ch:=readkey;
               if (ch='d')or(ch='D')
               then begin
                         if god=false
                         then god:=true
                         else god:=false;
                    end
                else exit;


           end
     else exit;
end;

procedure chit_carnage(var a:bots;level:byte);
var ch:char;
begin
      ch:=readkey;
      if (ch='i')or(ch='I')then
      begin
          ch:=readkey;
          if (ch='l')or(ch='L')then
          begin
            ch:=readkey;
            if (ch='l')or(ch='L')then
            begin
                if level<>200
                then begin
                   t.init_bot(a);
                   t.init_shot(a,0);
                   point:=point+10*level;
                   window(1,1,49,25);
                   clrscr;
               end;
            end
            else exit;
          end
          else exit;
      end
      else exit;

end;

function level:byte;
begin

           case point of
              -10000..49:level:=1;
              50..1049:level:=200;
              1050..1149:level:=2;
              1150..2149:level:=200;
              2150..2299:level:=3;
              2300..3299:level:=200;
              3300..3499:level:=4;
              3500..4499:level:=200;
              4500..4749:level:=5;
              4750..5749:level:=200;
              5750..6049:level:=6;
              6050..7049:level:=200;
              7050..7399:level:=7;
              7400..8399:level:=200;
              8400..8799:level:=8;
              8200..9199:level:=200;
              9200..10249:level:=9;
             else if (point mod 2000 =0)or(point mod 5000=0)
                    then level:=200
                    else level:=10;
            end;
end;



var    x,y,i,j:longint;
       ch:char;
       b:bots;
       hbot:headbot;
       spisok:tableofscore;


begin
     clrscr;
     score(spisok,'r','s');
     g.cursoroff;
     g.init;
     g.wall(point,level,hbot.life);

men: case menu of
       10:goto return;
       11:goto new_game;
       12:begin score(spisok,'w','s');goto men;end;
       13:begin help;goto men;end;
       14:begin score(spisok,'w','f'); halt;end;
     end;

new_game:
     score(spisok,'w','f');
     window(1,1,49,25);
     clrscr;
     t.init_bot(b);
     t.init_shot(b,0);
     hb.init_hbot(hbot);
     start:=true;
     deadc:=false;
     point:=0;
     x:=25;
     j:=1;

     repeat
return:   if ch=#27  then clrscr;
          t.byb(b,level);

          g.wall(point,level,hbot.life);

          if j=1000
          then t.bot(b,x,level,point,god,deadc);

          if j mod 800=0
          then begin
                    t.bot_shot(b,x,level,god,deadc);
                    hb.head_bot(hbot,x,level,god,deadc);
                    if level=200 then t.init_shot(b,0);
               end;

          c.paint_chel(x);

          if keypressed then begin
             ch:=readkey;
             if ch=#0 then ch:=readkey;
             window(x-1,23,x+1,25);     {�������� ��ࠡ��}
             clrscr;                    {�������� ��ࠡ��}
             case ch of
              #77:if x<48 then inc(x);
              #75:if x>3 then dec(x);
              #32:begin c.paint_chel(x);c.shot_chel(x,b,level,hbot,point);end;
              'g','G':chit_god;
              'p','P':begin
                          window(30,12,35,13);
                          write('��㧠');
                          repeat

                          until keypressed;
                          clrscr;
                      end;
              'k','K':chit_carnage(b,level);
              #27:goto men;

             end;
          end;

          c.paint_chel(x);

          if j>=4000 then j:=1  {j-᪮���� ���}
          else inc(j);

       until (deadc=true);

       if deadc then
       begin
         window(30,12,44,13);
         write('��� �ந�࠭�');
         window(24,14,49,23);
         writeln('�� ���ࠫ� ',point,' �窮�');
         write('������ ��� ���: ');readln(spisok[11].name);
         spisok[11].point:=point;
         clrscr;

         write('��� �த������� ������ ���� ������');
         textcolor(white);
         ClearBuffer;

         repeat

         until keypressed;
         clearBuffer;
         window(1,1,50,25);
         clrscr;

         start:=false;

       end;
       goto men;

end.