
      integer :: start_time, end_time, time, clock_rate

!     Get the clock rate
      call system_clock(count_rate=clock_rate)
      
!     Get the start time
      call system_clock(start_time)

!     Your code to measure the execution time goes here
!     For example, a loop that takes some time
      do i = 1, 1000000
!     Some computational code
      end do

!     Get the end time
      call system_clock(end_time)
      
!     Calculate the elapsed time
      time = end_time - start_time
      end
