
      
      call srand(352)
      l = 0
      do i = -10, 10
         do j = -10, 10
            if (rand() <= 0.1 ) then
               l = l + 1
            end if 
         end do
      end do

      write(*, *) l 
      
      end
