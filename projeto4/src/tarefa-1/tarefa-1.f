      implicit integer (c-c, r-r)
      ! C_{t}
      L = 50
      K = 30
      print *, "Forneca regra R [0, 255]"

      read(*, *) R
      
      open(unit = 1, file="rule-#-0.dat")
      open(unit = 2, file="rule-#-1.dat")
      open(unit = 3, file="rule-#-2.dat")

      call DCA(R, K, L, 0, 1)
      call DCA(R, K, L, 1, 2)
      call DCA(R, K, L, 2, 3)

      close(1)
      close(2)
      close(3)
      end
