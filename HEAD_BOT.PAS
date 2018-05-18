unit head_botlib;
interface
uses crt,gamelib;

type head_bot=object
     public
        procedure init_hbot(var hbot:headbot);
        procedure paint_h_tracer(x,y:integer;f:boolean;c:byte);
        procedure shot_hbot(var hbot:headbot;xchel:byte;god:boolean;var deadc:boolean);
        procedure paint_head_bot(x:byte;f:boolean);
        procedure head_bot(var h_bot:headbot;xchel:integer;level:byte;god:boolean;var deadc:boolean);
end;

implementation

procedure head_bot.init_hbot(var hbot:headbot);
var i,j:byte;
begin
     with hbot do
     begin
       for i:=1 to 49 do
         for j:=3 to 23 do
           hbot.shot1[i,j]:=false;

       dead:=true;
       dx:=1;
       life:=20;
       x:=25;
     end;
end;

procedure head_bot.paint_h_tracer(x,y:integer;f:boolean;c:byte);
begin
      textcolor(lightred);
      window(x,y,x,y+1);
      if not f then clrscr
      else if c=1 then write(#250);

      textcolor(white);
end;


procedure head_bot.shot_hbot(var hbot:headbot;xchel:byte;god:boolean;var deadc:boolean);
var i,j:byte;
begin
     randomize;
     with hbot do
     begin

             if random(2)=0 then shot1[x,3]:=false
             else shot1[x,3]:=true;
             if random(2)=0 then shot1[x-3,3]:=false
             else shot1[x-3,3]:=true;
             if random(2)=0 then shot1[x+3,3]:=false
             else shot1[x+3,3]:=true;


          for i:=1 to 49 do
          begin
             for j:=23 downto 4 do
               shot1[i,j]:=shot1[i,j-1];
             shot1[i,3]:=false;
          end;
     end;
     for i:=1 to 49 do
         for j:=3 to 22 do  with hbot do
         begin

           paint_h_tracer(i,j,shot1[i,j],1);
           paint_h_tracer(i,j+2,shot1[i,j],1);
           paint_h_tracer(i,j,shot1[i,j],1);

         end;
    with hbot do
      if (shot1[xchel,23]=true)or(shot1[xchel-1,23]=true)or
         (shot1[xchel+1,23]=true)
      then begin
                   if not god then deadc:=true
                   else deadc:=false;
           end;
end;

procedure head_bot.paint_head_bot(x:byte;f:boolean);
begin
     textcolor(brown);
     window(x-3,2,x+3,5);
     if not f then clrscr
     else begin
             write(#201,#219,#219,#219,#219,#219,#187);
             write('  ',#219,#219,#219,'  ');
             write('  ',#205,#203,#205);
     end;
     window(1,1,49,25);
     textcolor(white);
end;

procedure head_bot.head_bot(var h_bot:headbot;xchel:integer;level:byte;god:boolean;var deadc:boolean);
var i,j:byte;
begin
      if level=200 then h_bot.dead:=false;


        if h_bot.dead=false then
        begin
           with h_bot do
           begin
                paint_head_bot(x,false);
                if (x+3>49)or(x-3<2)then dx:=-dx;
                x:=x+dx;
           end;

           shot_hbot(h_bot,xchel,god,deadc);

           paint_head_bot(h_bot.x,true);
        end

      else init_hbot(h_bot);
end;

end.