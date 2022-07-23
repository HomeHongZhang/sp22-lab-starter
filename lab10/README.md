## Solutions for exercises in lab10

### Exercice 2: Misses
The goal for this exercise is to create a workload of ten memory accesses that will cause ten TLB misses and ten Page Faults.
> We know that the camera uses **LRU policy** to replace the Physical Memory Page Frame, and The size of the TLB is `4`. SO what we need to do is to make sure that the current VPN(Virtual Page Number) has been replaced, if we want a ten times TLB misses.
> Example Solution can be like:
> 0x01, 0000 0001
> 0x22, 0010 0010
> 0x43, 0100 0011
> 0x64, 0110 0100
> 0x85, 1000 0101
> 0xA6, 1010 0110
> 0xC7, 1100 0111
> 0xE8, 1110 1000
> 0x01, 0000 0001 or 0x64, 0110 0100
> 0x22, 0010 0010 or 0x43, 0100 0011


### Exercise 3: Fixing our Faults
The goal for this exercise is to modify a single parameter(eg: TLB size, Physical Memory Size, Virtual Memory Size, Page size) that would result in the same number (ten) of TLB misses but result in fewer than then page faults? There are two correct answers.
> TLB Size, Physical Memory Size
> Let's consider the case that causes a TLB Miss but not a Fage Fault when loading a word. If the word is just in the Physical Memory it would not cause a Page Fault. SO one solution is to change the Physical Memory Size that bigger than TLB size. Another solution is to decrease the TLB's szie to make sure that is smaller than the Physical Memory size. Beacause in the **camera**, the TLB's size is equal to the Physical Memory size.
