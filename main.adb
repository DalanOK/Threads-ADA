with Ada.Text_IO;
procedure Main is
   can_stop : boolean := false;
   pragma Atomic(can_stop);

   task type break_thread;
   task type main_thread;
   id: Integer := 0;
   task body break_thread is
   begin
      delay 1.0;
      can_stop := true;
   end break_thread;

   task body main_thread is
      sum : Long_Long_Integer := 0;
      step : Long_Long_Integer := 4;
      counter : Integer := 0;
      thread_id: Integer;
   begin
      thread_id := id;
      id := id + 1;
      loop
         sum := sum + step;
         counter := counter + 1;
         exit when can_stop;
      end loop;
      delay 1.0;

      Ada.Text_IO.Put_Line("Id:" & thread_id'Img & " Sum:" & sum'Img & " Counter:" & counter'Img & " Step:" & step'Img);
   end main_thread;

   b1 : break_thread;
   threads : array (1..5) of main_thread;
   begin
   null;
end Main;
