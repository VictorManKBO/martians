unit botlib;
interface
uses crt,gamelib;
type


  bot=object
  public
    procedure paint_bot(x,y:integer;f:boolean);
    procedure init_bot(var a:bots);
    procedure init_shot(var a:bots;n:byte);
	procedure byb(var a:bots;level:byte);
	procedure bot(var a:bots;xchel:integer;level:byte;var point:longint;god:boolean;var deadc:boolean);
	procedure paint_tracer(x,y:integer;f:boolean);
	procedure bot_shot(var a:bots;xchel:integer;level:byte;god:boolean;var deadc:boolean);
    end;

implementation

procedure bot.paint_bot(x,y:integer;f:boolean);
begin
      textcolor(lightmagenta);
      window(x-1,y,x+1,y+1);
      if not f then clrscr
      else
      begin
           write(#219,#219,#219);
           write(' ',#186);
      end;
      textcolor(white);
end;

procedure bot.init_bot(var a:bots);
var i,j:byte;
begin
     for i:=1 to 10 do with a.bot[i] do
     begin
         place[2]:=2;
         dead:=true;
     end;
end;

procedure bot.init_shot(var a:bots;n:byte);
var i,j:byte;
begin
     if n=0
	 then begin
               for i:=1 to 50 do
                 for j:=1 to 23 do
                   a.shot[i,j]:=false;
     	  end
     else for i:=1 to 50 do
          begin
             for j:=23 downto 4 do
			   a.shot[i,j]:=a.shot[i,j-1];
             a.shot[i,3]:=false;
          end;
end;

procedure bot.byb(var a:bots;level:byte);
var i:byte;
begin
     randomize;
     if level<>200 then
     begin
         for i:=1 to  level do
         begin
           if (a.bot[i].dead=true)
           then with a.bot[i] do
                begin
                     place[1]:=random(46)+3;
                     place[2]:=2;
                     dead:=false;
                 end;

            if a.bot[i].dead=false then
            begin
                paint_bot(a.bot[i].place[1],a.bot[i].place[2]-1,false);
                paint_bot(a.bot[i].place[1],a.bot[i].place[2],true);
            end;
         end;
      end;
end;

procedure bot.bot(var a:bots;xchel:integer;level:byte;var point:longint;god:boolean;var deadc:boolean);
var i,j,k:byte;

begin
     if level<>200 then
     begin
       for j:=1 to level do
          with a.bot[j] do
           if dead=false then
            begin
                if (place[2]=23)and((place[1]=xchel)or(place[1]=xchel-1)or
                (place[1]=xchel+1))
                then begin
                          if not god then deadc:=true
                           else deadc:=false;
                     end
                else if place[2]<23 then inc(place[2])

                     else begin
                             dead:=true;
                             paint_bot(place[1],place[2],false);
                             dec(point,10);
                          end;
            end
            else clrscr;
      end;
end;

procedure bot.paint_tracer(x,y:integer;f:boolean);
begin
      textcolor(lightcyan);
      window(x,y,x,y+1);
      if not f then clrscr
      else write(#249);
	  window(1,1,49,25);
      textcolor(white);
end;

procedure bot.bot_shot(var a:bots;xchel:integer;level:byte;god:boolean;var deadc:boolean);
var i,j,k:byte;
begin
     if level<>200 then
     begin
        for k:=1 to level do
        begin
             randomize;

             if random(2)=0 then a.shot[a.bot[k].place[1],a.bot[k].place[2]+2]:=false
             else a.shot[a.bot[k].place[1],a.bot[k].place[2]+2]:=true;

	         for i:=1 to 50 do
		       for j:=1 to 23 do
		         paint_tracer(i,j,a.shot[i,j]);

             if (a.shot[xchel,23]=true)or(a.shot[xchel-1,23]=true)or
                 (a.shot[xchel+1,23]=true)
             then begin
                          if not god then deadc:=true
                           else deadc:=false;
                  end;
        end;

		init_shot(a,1);
     end;
end;

end.