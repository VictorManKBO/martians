unit chellib;
interface
uses crt,gamelib,botlib;
type


  chel=object
  private 
    b:bot;
  public
    procedure paint_chel(x:byte);
	procedure shot_chel(x:integer;var a:bots;level:byte;var hbot:headbot;var point:longint);
    end;

implementation
procedure chel.paint_chel(x:byte);
begin
     textcolor(lightgreen);
     window(x-1,23,x+1,25);
     writeln(' ',#220);
     write(#219,#223,#219);
     window(1,1,49,25);
     textcolor(white);
end;

procedure chel.shot_chel(x:integer;var a:bots;level:byte;var hbot:headbot;var point:longint);
var y,i:longint;
begin
     textcolor(yellow);
     y:=23;
     window(x,2,x,24);
     repeat
          write(#179);
          dec(y);
     until y<=2;
     delay(200);
     clrscr;

     if level<>200 then
     begin
        for i:=1 to level do with a.bot[i] do
        begin
            if (x=place[1])or(x+1=place[1])or(x-1=place[1]) then
            begin
               if dead=false then inc(point,10);
               dead:=true;
               window(1,1,49,23);
               clrscr;
               b.paint_bot(place[1],place[2],false);
            end;
        end;
     end

     else
     begin
        if hbot.dead=false then                          {Ѓ®бб}
         if hbot.life>1 then                           {Ѓ®бб}
         begin                                           {Ѓ®бб}
             if ((hbot.x-3)<=x)and(x<=(hbot.x+3))then dec(hbot.life);
         end                                             {Ѓ®бб}
         else begin                                      {Ѓ®бб}
		          hbot.dead:=true;                       {Ѓ®бб}
				  inc(point,1000);                       {Ѓ®бб}
				  hbot.life:=20;                         {Ѓ®бб}
			   end;                                      {Ѓ®бб}
     end;
     textcolor(white);
end;

end.