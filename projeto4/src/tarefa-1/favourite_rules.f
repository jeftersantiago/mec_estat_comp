      implicit integer (c-c, r-r)
      ! C_{t}
      L = 100
      K = 100

      open(unit = 1, file="output-1.dat")
      open(unit = 2, file="output-2.dat")
      open(unit = 3, file="output-3.dat")

      call DCA(18, K, L, 2, 1)
      call DCA_position(86, K, L, L/2, 2)
      call DCA_position(110, K, L, L, 3)

      close(1)
      close(2)
      close(3)
      end
